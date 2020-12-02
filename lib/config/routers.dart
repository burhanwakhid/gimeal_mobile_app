import 'package:flutter/material.dart';
import 'package:gimeal/ui/page/home_page/home_page.dart';
import 'package:gimeal/ui/page/login/login_page.dart';
import 'package:gimeal/ui/page/makanan_page/detail_makanan.dart';
import 'package:gimeal/ui/page/profil/profil.dart';
import 'package:gimeal/ui/page/register_page/register_page.dart';
import 'package:gimeal/ui/page/welcome_page/welcome_page.dart';

class Routers {
  static const String root = '/';
  static const String homePage = '/homePage';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String welcomePage = '/welcomePage';
  static const String detailMakanan = '/detailMakanan';
  static const String profil = '/profil';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => WelcomePage());
        break;
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case welcomePage:
        return MaterialPageRoute(builder: (_) => WelcomePage());
        break;
      case registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
        break;
      case detailMakanan:
        return MaterialPageRoute(builder: (_) => DetailMakanan());
        break;
      case profil:
        return MaterialPageRoute(builder: (_) => Profil());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
