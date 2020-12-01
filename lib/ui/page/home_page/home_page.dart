import 'package:flutter/material.dart';
import 'package:gimeal/config/app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Gimeal',),
      ),
      body: Center(child: Text('ini Halaman yang bakal pertama diakses',),),
    );
  }
}