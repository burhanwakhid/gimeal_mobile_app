import 'package:shared_preferences/shared_preferences.dart';

class MainSharedPreferences {
  final String onboardPrefKey = 'firstOpen';
  final String _idUser = 'idUser'; 
  final String _namaUser = 'namaUser'; 

  //todo untuk control onboarding

  Future<bool> isFirstOpenedApp() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(onboardPrefKey) ?? true;
  }

  Future<void> openAppFirstTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(onboardPrefKey, false);
  }

  /// =======================
  /// BEGIN SET ID USER
  /// =======================
  Future<void> setIdUser(String idUser) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await  _prefs.setString(_idUser, idUser);
  }

  Future<String> getIdUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_idUser) ?? '';
  }
  /// =======================
  /// END SET ID USER
  /// =======================

  /// =======================
  /// BEGIN SET USER NAME
  /// =======================
  Future<void> setUserName(String userName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await  _prefs.setString(_namaUser, userName);
  }

  Future<String> getUserName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_namaUser) ?? '';
  }
  /// =======================
  /// END SET USER NAME
  /// =======================
}
