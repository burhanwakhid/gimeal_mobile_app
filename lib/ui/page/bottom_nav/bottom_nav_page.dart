import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/page/home_page/home_page.dart';
import 'package:gimeal/ui/page/login/login_page.dart';
import 'package:gimeal/ui/page/notifikasi/notification_page.dart';
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
      'inactive': 'assets/Icon/icon_home.png',
      'active': 'assets/Icon/icon_home2.png',
    },
    {
      'icon': Icons.list,
      'inactive': 'assets/Icon/icon_paper.png',
      'active': 'assets/Icon/icon_paper2.png',
    },
    {
      'icon': Icons.add_circle,
      'inactive': 'assets/Icon/icon_add.png',
      'active': 'assets/Icon/icon_add.png',
    },
    {
      'icon': Icons.notifications,
      'inactive': 'assets/Icon/icon_notifcation.png',
      'active': 'assets/Icon/icon_notification2.png',
    },
    {
      'icon': Icons.person_outline_rounded,
      'inactive': 'assets/Icon/icon_user.png',
      'active': 'assets/Icon/icon_user2.png',
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
    NotificationPage(),
    Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _listPage[this.widget.index],
      bottomNavigationBar: Material(
        elevation: 4,
        color: Colors.white,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              bottomNavList.length,
              (index) => GestureDetector(
                onTap: () {
                  this.action(index: index);
                },
                child: Image.asset(
                  index == this.widget.index
                      ? bottomNavList[index]['active']
                      : bottomNavList[index]['inactive'],
                  height: index == 2 ? 50 : 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
