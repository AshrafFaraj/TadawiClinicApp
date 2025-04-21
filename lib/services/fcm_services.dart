import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("$token=========");
    return token;
  }
}
