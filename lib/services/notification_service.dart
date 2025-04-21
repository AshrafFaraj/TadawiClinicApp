import 'dart:convert';
import 'dart:io'; // For File
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationModel {
  final String title;
  final String body;
  final String? imageUrl; // Add imageUrl
  final Map<String, dynamic> data;
  NotificationModel({
    required this.title,
    required this.body,
    this.imageUrl, // Add imageUrl
    required this.data,
  });
}

class NotificationService extends GetxService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final List<NotificationModel> _notifications = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<NotificationService> init() async {
    await _initialize();
    return this;
  }

  Future<void> _initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
          '@mipmap/ic_launcher'), // Use default launcher icon
    );
    // await _flutterLocalNotificationsPlugin.initialize(initializationSettings)
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    _firebaseMessaging.onTokenRefresh.listen(_handleTokenRefresh);
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      await _handleNotification(initialMessage);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received a message while in the foreground!');
      await _handleNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _handleNotification(message);
    });
    _firebaseMessaging.getToken();
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    await _handleNotification(message);
  }

  static Future<void> _handleNotification(RemoteMessage message) async {
    final String? title = message.notification?.title ?? message.data['title'];
    final String? body = message.notification?.body ?? message.data['body'];
    final String? imageUrl =
        message.data['image']; // Get the image URL from the data
    print(
        'Handling notification with title: $title, body: $body, image: $imageUrl'); // Debugging line
    final int notificationId = message.messageId?.hashCode ?? message.hashCode;
    if (!_isNotificationHandled(notificationId)) {
      await _showNotification(
          notificationId, title, body, imageUrl, message.data);
      _addNotification(notificationId, title, body, imageUrl, message.data);
    }
  }

  static Future<void> _showNotification(int notificationId, String? title,
      String? body, String? imageUrl, Map<String, dynamic> data) async {
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (imageUrl != null) {
      final localPath = await _downloadAndSaveImage(imageUrl);

      if (localPath != null) {
        bigPictureStyleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(localPath),
          contentTitle: title ?? 'No Title',
          summaryText: body ?? 'No Body',
        );
      } else {
        print('Image download failed, falling back to simple notification.');
      }
    }
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation, // Set image or null
    );
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title ?? 'No Title',
      body ?? 'No Body',
      notificationDetails,
      payload: jsonEncode(data),
    );
  }

  static Future<String?> _downloadAndSaveImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final String? contentType = response.headers['content-type'];
        final String? extension = _getFileExtension(contentType);
        if (extension == null) {
          print('Unsupported image type');
          return null;
        }
        final Directory tempDir = await Directory.systemTemp.createTemp();
        final File file = File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.$extension');
        await file.writeAsBytes(response.bodyBytes);
        print('temp ${tempDir.path}');
        return file.path;
      } else {
        print('Failed to download image');
        return null;
      }
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  static String? _getFileExtension(String? contentType) {
    if (contentType == null) return null;
    if (contentType.contains('image/jpeg')) return 'jpg';
    if (contentType.contains('image/png')) return 'png';
    if (contentType.contains('image/gif')) return 'gif';
    if (contentType.contains('image/webp')) return 'webp';
    return null; // Unsupported image type
  }

  static void _addNotification(int notificationId, String? title, String? body,
      String? imageUrl, Map<String, dynamic> data) {
    _notifications.add(NotificationModel(
      title: title ?? 'No Title',
      body: body ?? 'No Body',
      imageUrl: imageUrl, // Add imageUrl
      data: data,
    ));
  }

  static bool _isNotificationHandled(int notificationId) {
    return _notifications
        .any((notification) => notification.title.hashCode == notificationId);
  }

  static Future<void> _handleTokenRefresh(String? newToken) async {
    if (newToken != null) {
      print("New FCM Token: $newToken");
      await _sendTokenToBackend(newToken);
    }
  }

  static Future<void> _sendTokenToBackend(String token) async {
    final prefs = await SharedPreferences.getInstance();
    String? authToken = await _getAuthToken();
    if (authToken != null) {
      prefs.setString('fcm_token', token);
    }
  }

  static Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  List<NotificationModel> get notifications => _notifications;
}

// ===========================================""
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initialize() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher'); // Use your app icon

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);

//     await _localNotificationsPlugin.initialize(initializationSettings);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         print('🔔 Title: ${message.notification!.title}');
//         print('📝 Body: ${message.notification!.body}');

//         // ✅ Show notification manually
//         showLocalNotification(message);
//       }
//     });
//   }

//   static void showLocalNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'default_channel_id',
//       'Default Channel',
//       channelDescription: 'This channel is used for default notifications.',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: true,
//     );

//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//     );

//     await _localNotificationsPlugin.show(
//       message.notification.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       platformDetails,
//     );
//   }
// }
