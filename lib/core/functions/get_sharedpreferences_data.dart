import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
