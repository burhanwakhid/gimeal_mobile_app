import 'package:flutter/material.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/shared/styles.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  List<Map> menu = [
    {
      'title': 'Unggahan',
      'image': 'assets/Icon/icon_upload.png',
      'route': '',
    },
    {
      'title': 'Penilaian',
      'image': 'assets/Icon/icon_star.png',
      'route': '',
    },
    {
      'title': 'Riwayat',
      'image': 'assets/Icon/icon_list.png',
      'route': '',
    },
    {
      'title': 'Bantuan',
      'image': 'assets/Icon/icon_help.png',
      'route': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          _userProfile(),
          SizedBox(
            height: 30,
          ),
          _statisticRow(context),
          SizedBox(
            height: 20,
          ),
          _profileMenu(),
          SizedBox(
            height: 40,
          ),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              onPressed: () {},
              child: Text(
                'Keluar',
                style: TextStyling(
                    color: Colors.grey, decoration: TextDecoration.underline)
                  ..big()
                  ..bold(),
              ),
              color: Colors.blueGrey.shade50,
            ),
          ),
        ],
      ),
    );
  }

  Padding _profileMenu() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: List.generate(menu.length, (index) {
          return ListTile(
            dense: true,
            leading: Image.asset(
              menu[index]['image'],
              height: 30,
            ),
            title: Text(
              menu[index]['title'],
              style: TextStyling(color: Colors.grey)
                ..big()
                ..bold(),
            ),
          );
        }),
      ),
    );
  }

  Row _statisticRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatisticContainer(context,
            imagePath: 'assets/Icon/icon_food.png',
            quantity: 8,
            title: 'Makanan yang telah dibagikan'),
        _buildStatisticContainer(context,
            imagePath: 'assets/Icon/icon_people.png',
            quantity: 5,
            title: 'Orang yang telah menerima makanan'),
      ],
    );
  }

  ListTile _userProfile() {
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          'https://i.pinimg.com/474x/9c/e5/7f/9ce57f4e94275efb3a4a39c69297a9e4.jpg',
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              'Juna Hermawan',
              style: TextStyling()
                ..huge()
                ..bold(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.mode_edit,
              size: 12,
            ),
            onPressed: () {},
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_rounded,
                color: Colors.greenAccent,
                size: 10,
              ),
              Flexible(
                child: Text(
                  'Bambang Ultraviolet, S.Pok',
                  style: TextStyling(color: Colors.grey)..small(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          RatingDisplay(
            value: 3.0,
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 2,
      title: Text(
        'Profil',
        style: TextStyling(color: Colors.black)..bold,
      ),
      backgroundColor: Colors.white,
    );
  }

  Container _buildStatisticContainer(
    BuildContext context, {
    @required String imagePath,
    @required int quantity,
    @required String title,
  }) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.black45, width: 0.8),
      ),
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          Text(
            quantity.toString(),
            style: TextStyling()
              ..bold()
              ..big(),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RatingDisplay extends StatelessWidget {
  RatingDisplay({
    @required this.value,
    this.size,
    this.starColor,
    Key key,
  });

  final double value;
  final Color starColor;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) => index <= value
            ? Icon(
                Icons.star,
                color: starColor ?? Colors.amberAccent,
                size: size ?? 16,
              )
            : Icon(
                Icons.star_border,
                color: starColor ?? Colors.amberAccent,
                size: size ?? 16,
              ),
      ),
    );
  }
}
