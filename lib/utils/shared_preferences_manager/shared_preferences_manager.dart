import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {

  late SharedPreferences _pref;

  SharedPreferencesManager();

  setPreference() async {
    _pref = await SharedPreferences.getInstance();
  }

  update({required SharedPreferencesKey key, required String? value}) {
    _pref.setString(key.toString(), value ?? "");
  }

  String? get({required SharedPreferencesKey key}) {
    return _pref.getString(key.toString());
  }

  updateBool({required SharedPreferencesKey key, required bool? value}) {
    _pref.setBool(key.toString(), value ?? false);
  }

  bool? getBool({required SharedPreferencesKey key}) {
    return _pref.getBool(key.toString());
  }
}

enum SharedPreferencesKey {
  example,
}