import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/home_page/home_page.dart';
import 'package:gimeal/ui/page/onboarding/onboarding_screen.dart';
import 'package:gimeal/ui/page/pesanan_makanan/pesanan_makanan_page.dart';
import 'package:gimeal/ui/page/welcome_page/welcome_page.dart';

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
        canvasColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routers.generateRoute,
      home: this.widget.firstOpen ? Onboarding() : PesananMakanan(),
//      BottomNav(index: 0),
    );
  }
}
