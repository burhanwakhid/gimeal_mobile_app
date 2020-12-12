import 'package:shared_preferences/shared_preferences.dart';

class MainSharedPreferences {
  final String onboardPrefKey = 'firstOpen';
  final String _idUser = 'idUser';
  final String _namaUser = 'namaUser';
  final String _fotoUser = 'fotoUser';
  final String _hpUser = 'hpUser';
  final String _email = 'email';

  //todo untuk control onboarding

  // CLEAR SHARE PREFERENCE
  Future<bool> clearSharedPreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.clear();
  }

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
    await _prefs.setString(_idUser, idUser);
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
    await _prefs.setString(_namaUser, userName);
  }

  Future<String> getUserName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_namaUser) ?? '';
  }

  /// =======================
  /// END SET USER NAME
  /// =======================

  /// =======================
  /// BEGIN SET USER FOTO
  /// =======================
  Future<void> setUserFoto(String userName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_fotoUser, userName);
  }

  Future<String> getUserFoto() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_fotoUser) ?? '';
  }

  /// =======================
  /// END SET USER FOTO
  /// =======================

  /// =======================
  /// BEGIN SET USER FOTO
  /// =======================
  Future<void> setHpUser(String userName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_hpUser, userName);
  }

  Future<String> getHpUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_hpUser) ?? '';
  }

  /// =======================
  /// END SET USER FOTO
  /// =======================

  /// =======================
  /// BEGIN SET USER EMAIL
  /// =======================
  Future<void> setEmailUser(String userName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_email, userName);
  }

  Future<String> getEmailUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(_email) ?? '';
  }

  /// =======================
  /// END SET USER EMAIL
  /// =======================
}
