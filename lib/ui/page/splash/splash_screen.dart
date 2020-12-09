import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int duration;
  final Widget afterSplash;
  final Color backgroundColor;

  SplashScreen({
    @required this.duration,
    @required this.afterSplash,
    this.backgroundColor,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplash() async {
    var duration = Duration(seconds: this.widget.duration);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => this.widget.afterSplash,
        ),
      );
    });
  }

  @override
  void initState() {
    this.startSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: this.widget.backgroundColor ?? Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: media.width / 3,
            ),
            Image.asset(
              'assets/Logo/Logo.png',
              width: media.width / 3,
            ),
            Image.asset(
              'assets/gif/ellipsis.gif',
              width: media.width / 5,
            )
          ],
        ),
      ),
    );
  }
}
