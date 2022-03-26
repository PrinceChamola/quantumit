
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{

  static SharedPreferences? _prefs;

  static const loginKey = "LoginKey";

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setLoginValue(String key, bool value) {
    if(_prefs != null) _prefs?.setBool(loginKey, value);
  }

  static bool getLoginValue(String key){
    return _prefs == null ? false : _prefs!.getBool(key) ?? false;
  }

  static sharedPreferenceClear() {
    _prefs?.clear();
  }


}