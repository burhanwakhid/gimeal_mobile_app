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
    Navigator.popAndPushNamed(context, Routers.welcomePage);
  }

  List<Map<String, dynamic>> _onBoardData = [
    {
      'title': 'Donasi Makanan Online',
      'body':
          'Begitu mudah kita dapat berbagi makanan kepada siapapun itu. Anda bisa berbagi kepada orang  yang membutuhkan melalui teman yang lain untuk menyalurkannya. Kita Semua Terhubung untuk dapat saling membagikan kepada orang-orang disekitar Kita.',
      'image': 'assets/onboard1.png',
    },
    {
      'title': 'Sebagai Penyalur Kepada Orang Lain',
      'body':
          'Saat anda melihat orang yang membutuhkan, anda dapat mencarikan donasi makanan disekitar anda untuk diberikan kepada orang yang membutuhkan tersebut. Begitu juga sebaliknya jika ada teman yang membutuhkan bantuan  untuk orang disekelilingnya, anda juga dapat membagikan makanan anda  diwaktu yang sama. Maka semakin luas area Donasi kita Bersama, dan semoga dapat memberi manfaat bagi semua.',
      'image': 'assets/onboard2.png',
    },
    {
      'title': ' ',
      'body':
          'Donasi Makanan akan menyertakan informasi Kondisi makanan yang akan didonasikan sehingga, para Penyalur dan Donatur dapat memperkirakan Waktu Penyaluran yang Update, dan Layak.',
      'image': 'assets/onboard3.png',
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
