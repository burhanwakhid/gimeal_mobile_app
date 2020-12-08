import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/page/home_page/home_page.dart';
import 'package:gimeal/ui/page/login/login_page.dart';
import 'package:gimeal/ui/page/on_progress/on_progress_page.dart';
import 'package:gimeal/ui/page/profil/profil.dart';
import 'package:gimeal/ui/page/unggah_makanan_page/unggah_makanan_page.dart';

class BottomNav extends StatefulWidget {
  int index;
  BottomNav({@required this.index});

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
    setState(() {
      this.widget.index = index;
    });
  }

  List<Widget> _listPage = [
    HomePage(),
    OnProgress(),
    UnggahMakananPage(),
    Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _listPage[this.widget.index],
      bottomNavigationBar: Material(
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
          currentIndex: this.widget.index,
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
      ),
    );
  }
}
