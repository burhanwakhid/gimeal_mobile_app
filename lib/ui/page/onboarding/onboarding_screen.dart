import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';

import 'package:introduction_screen/introduction_screen.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  //todo fungsi ketika selesai dari onboard screen
  void _onDone() {
    MainSharedPreferences().openAppFirstTime();
    Navigator.popAndPushNamed(context, Routers.homePage);
  }

  List<Map<String, dynamic>> _onBoardData = [
    {
      'title': 'Donasi Makanan Online',
      'body': 'Membagikan makanan kepada orang lain tanpa keluar rumah',
      'image': 'assets/Illustrasi/ilustrasi_1.png',
    },
    {
      'title': 'Mendapatkan Makanan Gratis',
      'body': 'Memilih makanan yang berada di sekitar tempat tinggal anda',
      'image': 'assets/Illustrasi/ilustrasi_2.png',
    },
    {
      'title': 'Mengambil makanan secara langsung',
      'body':
          'Anda dapat mengambil makanan secara langsung untuk memeriksa kondisi makanan tersebut',
      'image': 'assets/Illustrasi/ilustrasi_3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: List<PageViewModel>.generate(_onBoardData.length, (index) {
        return index == _onBoardData.length - 1
            ? PageViewModel(
                title: _onBoardData[index]['title'],
                body: _onBoardData[index]['body'],
                image: Center(
                  child: Image.asset(_onBoardData[index]['image'], height: 250),
                ),
                footer: RaisedButton(
                  onPressed: () {
                    this._onDone();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: kMainColor,
                  child: Text('Mulai'),
                ),
              )
            : PageViewModel(
                title: _onBoardData[index]['title'],
                body: _onBoardData[index]['body'],
                image: Center(
                  child: Image.asset(_onBoardData[index]['image'], height: 250),
                ),
              );
      }),
      onDone: () {
        this._onDone();
      },
      done: Container(),
      dotsDecorator: DotsDecorator(
          activeColor: kMainColor, activeSize: Size.fromRadius(8)),
    );
  }
}
