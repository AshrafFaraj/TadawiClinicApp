import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'notification_service.dart';

class MyServices extends GetxService {
  late Box _box;
  Future<void> storeData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<bool> storeDataBool(String key, dynamic value) async {
    try {
      await _box.put(key, value);
      return true; // Return true when data is successfully stored
    } catch (e) {
      return false; // Return false if an error occurs while storing data
    }
  }

  dynamic getData(String key) {
    if (_box.containsKey(key)) {
      return _box.get(key);
    }
    return null;
  }

  Future<void> clearData(String key) async {
    await _box.delete(key);
  }

  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  Future<MyServices> init() async {
    _box = await Hive.openBox('appBox');
    fetchUserDatafromCach();

    return this;
  }

  fetchUserDatafromCach() {
    final data = getData('userData');
    if (data is Map) {
      userData.value = Map<String, dynamic>.from(data);
    }
  }
}

initialServices() async {
  await Get.putAsync<MyServices>(() => MyServices().init());
  await Get.putAsync<NotificationService>(() => NotificationService().init());
}
