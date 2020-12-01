import 'package:shared_preferences/shared_preferences.dart';

class MainSharedPreferences {
  final String onboardPrefKey = 'firstOpen';

  //todo untuk control onboarding

  Future<bool> isFirstOpenedApp() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(onboardPrefKey) ?? true;
  }

  Future<void> openAppFirstTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(onboardPrefKey, false);
  }
}
