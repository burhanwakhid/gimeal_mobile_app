import 'package:flutter/material.dart';
import 'package:gimeal/config/routers.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gimeal',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Color(0xFF72C81A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
