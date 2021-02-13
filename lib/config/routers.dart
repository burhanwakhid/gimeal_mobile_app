import 'package:flutter/material.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/ui/page/bantuan/bantuan_page.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/kriteria/kriteria_donatur.dart';
import 'package:gimeal/ui/page/laporkan/laporkan_page.dart';
import 'package:gimeal/ui/page/login/login_page.dart';
import 'package:gimeal/ui/page/makanan_page/detail_makanan.dart';
import 'package:gimeal/ui/page/privacy/privacy.dart';
import 'package:gimeal/ui/page/profil/edit_profil.dart';
import 'package:gimeal/ui/page/rating/rating_page.dart';
import 'package:gimeal/ui/page/register_page/register_page.dart';
import 'package:gimeal/ui/page/riwayat/history_page.dart';
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
  static const String bantuan = '/bantuan';
  static const String notification = '/notification';
  static const String onProgress = '/onProgress';
  static const String penilaian = '/penilaian';
  static const String riwayat = '/riwayat';
  static const String editProfile = '/editProfile';
  static const String privacyPage = '/privacyPage';
  static const String donaturPage = '/donaturPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => WelcomePage());
        break;
      case homePage:
        return MaterialPageRoute(builder: (_) => BottomNav(index: 0));
        break;
      case profil:
        return MaterialPageRoute(builder: (_) => BottomNav(index: 4));
        break;
      case notification:
        return MaterialPageRoute(builder: (_) => BottomNav(index: 3));
        break;
      case onProgress:
        return MaterialPageRoute(builder: (_) => BottomNav(index: 1));
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
      case bantuan:
        return MaterialPageRoute(builder: (_) => BantuanPage());
        break;
      case penilaian:
        return MaterialPageRoute(builder: (_) => RatingPage());
        break;
      case riwayat:
        return MaterialPageRoute(builder: (_) => HistoryPage());
        break;
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
        break;
      case privacyPage:
        return MaterialPageRoute(builder: (_) => PrivacyPage());
        break;
      case donaturPage:
        return MaterialPageRoute(builder: (_) => DonaturPage());
        break;
      case detailMakanan:
        if (args is DetailMakananArgs)
          return MaterialPageRoute(
            builder: (_) => DetailMakanan(),
          );
        else
          return null;
        break;

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
        break;
    }
  }
}

class DetailMakananArgs {
  final ListFoodModel listFoodModel;

  DetailMakananArgs({
    this.listFoodModel,
  });
}
