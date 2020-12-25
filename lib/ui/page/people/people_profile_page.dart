import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimeal/core/models/user_model.dart';
import 'package:gimeal/core/services/firebase_firestore/FireUserService.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';
import 'package:gimeal/ui/widgets/rating_display.dart';

import '../../../config/routers.dart';
import '../../../core/shared_preferences/config_shared_preferences.dart';

class PeopleProfile extends StatefulWidget {
  final String id;
  PeopleProfile({
    this.id,
  });
  @override
  _PeopleProfileState createState() => _PeopleProfileState();
}

class _PeopleProfileState extends State<PeopleProfile> {
  Future<UserModel> _user;

  Future getData() async {
    _user = UserServices.getUser(widget.id);
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: FutureBuilder<UserModel>(
          future: _user,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return LinearProgressIndicator();
                break;
              case ConnectionState.none:
                return LinearProgressIndicator();
                break;
              case ConnectionState.active:
                return LinearProgressIndicator();
                break;
              case ConnectionState.done:
                return buildResult(context, data: snapshot.data);
                break;
              default:
                return LinearProgressIndicator();
                break;
            }
          },
        ),
      ),
    );
  }

  ListView buildResult(BuildContext context, {UserModel data}) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _userProfile(data: data),
        SizedBox(
          height: 30,
        ),
        _statisticRow(context),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Makanan dalam proses',
            style: TextStyling()
              ..bold()
              ..big(),
          ),
        ),
        TransparentDivider(),
        buildListOnProgress(context),
        TransparentDivider(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Makanan telah terselesaikan',
            style: TextStyling()
              ..bold()
              ..big(),
          ),
        ),
        TransparentDivider(),
        buildFinishedOrder(),
      ],
    );
  }

  Container buildFinishedOrder() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 100),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return TransparentDivider();
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    'https://www.inibaru.id/nuploads/1/umum/grontol%202.jpg',
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Jagung Rebus',
                          style: TextStyling()..bold(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 10,
                            ),
                            Text(
                              ' Terdonasikan',
                              style: TextStyling(color: Colors.grey)..small(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        RatingDisplay(value: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildListOnProgress(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    'https://www.inibaru.id/nuploads/1/umum/grontol%202.jpg',
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jagung Rebus',
                        style: TextStyling()..bold(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 10,
                          ),
                          Text(
                            '500 m',
                            style: TextStyling(color: Colors.grey)..small(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 10,
                          ),
                          Text(
                            ' 16.00 - 20.00 pm',
                            style: TextStyling(color: Colors.grey)..small(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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

  Widget _userProfile({UserModel data}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/user%2${data.fotoUser}.png?alt=media',
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nama,
                    style: TextStyling()
                      ..big()
                      ..bold(),
                    overflow: TextOverflow.fade,
                  ),
                  TransparentDivider(),
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
                              ' ${data.email}',
                              style: TextStyling(color: Colors.grey)..big(),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TransparentDivider(),
                  RatingDisplay(
                    value: 4,
                    size: 16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.grey,
      ),
      elevation: 2,
      title: Text(
        'Profil Pengguna',
        style: TextStyling(color: Colors.grey)..bold(),
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
