import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  bool get isLoggedIn => _sharedPrefs!.getBool('isLoggedIn') ?? false;

  bool get isBotTrading => _sharedPrefs!.getBool('isBotTrading') ?? false;

  String get userEmail => _sharedPrefs!.getString('userEmail') ?? "";

  set isLoggedIn(bool value) {
    _sharedPrefs!.setBool('isLoggedIn', value);
  }

  set isBotTrading(bool value) {
    _sharedPrefs!.setBool('isBotTrading', value);
  }

  set userEmail(String value) {
    _sharedPrefs!.setString('userEmail', value);
  }
}

final sharedPrefs = SharedPrefs();
