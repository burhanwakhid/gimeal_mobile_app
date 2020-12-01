import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Map> bottomNavList = [
    {
      'icon': Icons.home,
    },
    {
      'icon': Icons.list,
    },
    {
      'icon': Icons.add_circle,
    },
    {
      'icon': Icons.chat,
    },
    {
      'icon': Icons.person_outline_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
      ],
    );
  }
}
