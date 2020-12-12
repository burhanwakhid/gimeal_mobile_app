import 'package:flutter/material.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/home_page/home_page.dart';
import 'package:gimeal/ui/page/laporkan/laporkan_page.dart';
import 'package:gimeal/ui/page/login/login_page.dart';
import 'package:gimeal/ui/page/makanan_page/detail_makanan.dart';
import 'package:gimeal/ui/page/profil/profil.dart';
import 'package:gimeal/ui/page/register_page/register_page.dart';
import 'package:gimeal/ui/page/unggah_makanan_page/unggah_makanan_page.dart';
import 'package:gimeal/ui/page/unggahan/list_unggahan_page.dart';
import 'package:gimeal/ui/page/welcome_page/welcome_page.dart';

class Routers {
  static const String root = '/';
  static const String homePage = '/homePage';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String welcomePage = '/welcomePage';
  static const String unggahMakanan = '/unggahMakanan';
  static const String detailMakanan = '/detailMakanan';
  static const String profil = '/profil';
  static const String laporkan = '/laporkan';
  static const String unggahan = '/unggahan';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => WelcomePage());
        break;
      case homePage:
        return MaterialPageRoute(builder: (_) => BottomNav(index: 0));
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
      case unggahMakanan:
        return MaterialPageRoute(builder: (_) => UnggahMakananPage());
        break;
      case laporkan:
        return MaterialPageRoute(builder: (_) => LaporkanPage());
        break;
      case unggahan:
        return MaterialPageRoute(builder: (_) => ListUnggahanPage());
        break;
      case detailMakanan:
        if (args is DetailMakananArgs)
          MaterialPageRoute(
            builder: (_) => DetailMakanan(),
          );
        break;
      case profil:
        return MaterialPageRoute(builder: (_) => BottomNav(index: 3));
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

class DetailMakananArgs {
  final ListFoodModel listFoodModel;

  DetailMakananArgs({
    this.listFoodModel,
  });
}
