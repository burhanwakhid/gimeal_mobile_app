import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/shared%20preferences/config_shared_preferences.dart';
import 'package:gimeal/ui/page/home_page/home_page.dart';
import 'package:gimeal/ui/page/onboarding/onboarding_screen.dart';

//class App extends StatelessWidget {
//  final bool _firstOpen =  await MainSharedPreferences().isFirstOpenedApp();
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Gimeal',
//      theme: ThemeData(
//        primarySwatch: kMainColor,
//        accentColor: kAccentColor,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      onGenerateRoute: Routers.generateRoute,
//      home: bool ? Onboarding(),
//    );
//  }
//}

class App extends StatefulWidget {
  final bool firstOpen;

  App({
    @required this.firstOpen,
  });

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gimeal',
      theme: ThemeData(
        primarySwatch: kMainColor,
        accentColor: kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routers.generateRoute,
      home: this.widget.firstOpen ? Onboarding() : HomePage(),
    );
  }
}
