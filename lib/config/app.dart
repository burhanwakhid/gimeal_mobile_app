import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/ui/page/onboarding/onboarding_screen.dart';

import '../ui/page/home_page/home_page.dart';

class App extends StatelessWidget {
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
      home: Onboarding(),
    );
  }
}
