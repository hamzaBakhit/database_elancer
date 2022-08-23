import 'package:database_elancer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { language, id, name, email, loggedIn }

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initialPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void changeLang({required String langCode}) {
    _sharedPreferences.setString(PrefKeys.language.name, langCode);
  }

  //****************** SAVE THE EMAIL ********************//
  void save({required User user}) {
    _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    _sharedPreferences.setInt(PrefKeys.loggedIn.name, user.id );
    _sharedPreferences.setString(PrefKeys.email.name, user.email);
    _sharedPreferences.setString(PrefKeys.name.name, user.name);
  }

  T? getValueFor<T>(String key) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> removeValueFor(String key) async {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
