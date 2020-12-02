import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';

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
      'icon': Icons.person_outline_rounded,
    },
  ];

  void navigate({@required String navigateTo}) {
    Navigator.pushNamed(context, navigateTo);
  }

  void action({@required int index}) {
    switch (index) {
      case 0:
        this.navigate(navigateTo: Routers.homePage);
        break;
      case 1:
        this.navigate(navigateTo: Routers.welcomePage);
        break;
      case 2:
        this.navigate(navigateTo: Routers.loginPage);
        break;
      case 3:
        this.navigate(navigateTo: Routers.welcomePage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        items: bottomNavList.map<BottomNavigationBarItem>((item) {
          return BottomNavigationBarItem(
            label: '',
            icon: Icon(
              item['icon'],
            ),
          );
        }).toList(),
        selectedItemColor: kMainColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          this.action(index: index);
        },
      ),
    );
  }
}
