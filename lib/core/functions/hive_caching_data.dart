import 'package:hive/hive.dart';

Future<void> hiveCachingData(
    Map<String, dynamic> data, String openBoxName, dataKeyName) async {
  dynamic box = await Hive.openBox(openBoxName);
  await box.put(dataKeyName, data);
}
