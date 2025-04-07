import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MyServices extends GetxService {
  late Box _box;
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  // تهيئة Hive وفتح صندوق عام لتخزين البيانات (مثلاً 'appBox')
  Future<MyServices> init() async {
    _box = await Hive.openBox('appBox');
    userData.value = Map<String, dynamic>.from(getData('userData'));

    return this;
  }

  // دالة عامة لتخزين البيانات بأي مفتاح
  Future<void> storeData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  // دالة عامة لاسترجاع البيانات بأي مفتاح
  dynamic getData(String key) {
    if (_box.containsKey(key)) {
      return _box.get(key);
    }
    return <String, dynamic>{};
  }

  // دالة عامة لحذف بيانات بواسطة المفتاح
  Future<void> clearData(String key) async {
    await _box.delete(key);
  }
}

initialServices() async {
  await Get.putAsync<MyServices>(() => MyServices().init());
}
