import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gimeal/core/shared%20preferences/config_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _firstOpen = await MainSharedPreferences().isFirstOpenedApp();
  await Firebase.initializeApp();
  runApp(App(
    firstOpen: _firstOpen,
  ));
}
