import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {

  static SharedPreferences? pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
}) async {
    if (value is String) {
      return await pref!.setString(key, value);
    }
    else if (value is bool) {
      return await pref!.setBool(key, value);
    }
    else if (value is int) {
      return await pref!.setInt(key, value);
    }
    else {
      return await pref!.setDouble(key, value);

    }
  }

  static dynamic getData({required String key}) {
    return pref!.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await pref!.remove(key);
}

}