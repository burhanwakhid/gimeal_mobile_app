import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';
import 'package:gimeal/ui/widgets/rating_display.dart';

import '../../../config/routers.dart';
import '../../../core/shared_preferences/config_shared_preferences.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  List<Map> menu = [
    {
      'title': 'Unggahan',
      'image': 'assets/Icon/icon_upload.png',
      'route': '/unggahan',
    },
    {
      'title': 'Penilaian',
      'image': 'assets/Icon/icon_star.png',
      'route': '/penilaian',
    },
    {
      'title': 'Riwayat',
      'image': 'assets/Icon/icon_list.png',
      'route': '/riwayat',
    },
    {
      'title': 'Bantuan',
      'image': 'assets/Icon/icon_help.png',
      'route': '/bantuan',
    },
  ];

  String nama = '';
  String imagePhoto = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var name = await MainSharedPreferences().getUserName();
    var photo = await MainSharedPreferences().getUserFoto();
    setState(() {
      nama = name;
      imagePhoto = photo;
    });
  }

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
              onPressed: () async {
                _showMyDialog();
              },
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomDialogWidget(
          title: 'Keluar',
          desc: 'Apakah anda yakin?',
          textBtn1: 'Batal',
          textBtn2: 'Oke',
          onTapBtn1: () => Navigator.pop(context),
          onTapBtn2: () async {
            await MainSharedPreferences().clearSharedPreference();
            Navigator.pushNamedAndRemoveUntil(
                context, Routers.welcomePage, (route) => false);
          },
        );
      },
    );
  }

  Padding _profileMenu() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: List.generate(menu.length, (index) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, menu[index]['route']);
            },
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

  Widget _userProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/user%2$imagePhoto.png?alt=media',
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$nama',
                      style: TextStyling()
                        ..big()
                        ..bold(),
                      overflow: TextOverflow.fade,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/editProfile');
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/Icon/checkmark-filled.png',
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            'Bergabung 2 minggu yang lalu',
                            style: TextStyling(color: Colors.grey)..normal(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                RatingDisplay(value: 4),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 2,
      title: Text(
        'Profil',
        style: TextStyling(color: Colors.black)..bold(),
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
      padding: EdgeInsets.all(6.0),
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
            style: TextStyling()..tiny(),
          ),
        ],
      ),
    );
  }
}
