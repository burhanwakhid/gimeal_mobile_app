import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/provider/navbar_provider.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/kriteria/kriteria_donatur.dart';
import 'package:gimeal/ui/page/onboarding/onboarding_screen.dart';
import 'package:gimeal/ui/page/people/people_profile_page.dart';
import 'package:gimeal/ui/page/privacy/privacy.dart';
import 'package:gimeal/ui/page/profil/edit_profil.dart';
import 'package:gimeal/ui/page/splash/splash_screen.dart';
import 'package:gimeal/ui/page/welcome_page/welcome_page.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  final bool firstOpen;
  final bool isLogin;

  App({
    @required this.firstOpen,
    @required this.isLogin,
  });

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavbarProvider()),
      ],
      child: MaterialApp(
        title: 'Gimeal',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryColor: kMainColor,
          accentColor: kAccentColor,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: Routers.generateRoute,
        //  home: this.widget.firstOpen ? Onboarding() : WelcomePage(),
        home: SplashScreen(
          duration: 4,
          afterSplash: this.widget.firstOpen
              ? Onboarding()
              : this.widget.isLogin
                  ? BottomNav(index: 0)
                  : WelcomePage(),
        ),
//      BottomNav(index: 0),
      ),
    );
  }
}
