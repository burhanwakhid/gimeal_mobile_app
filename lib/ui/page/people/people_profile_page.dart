import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimeal/core/helper/date_formatter.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/models/user_model.dart';
import 'package:gimeal/core/services/firebase_firestore/FireUserService.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_service.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:gimeal/ui/widgets/rating_display.dart';

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
  Future<List<ListFoodTransactionModel>> _onProgress;
  Future<List<ListFoodModel>> _foods;

  Future getData() async {
    _user = UserServices.getUser(widget.id);
    _onProgress = FireFoodTransactionService.getUserOrderOnProgress(widget.id);
    _foods = FoodServices.getProfileUserFood(widget.id);
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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: FutureBuilder(
          future: Future.wait([_user, _onProgress, _foods]),
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
                return buildResult(context,
                    data: snapshot.data[0],
                    listTransaction: snapshot.data[1],
                    foods: snapshot.data[2],
                    counter: snapshot.data[1].length);
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

  ListView buildResult(BuildContext context,
      {UserModel data,
      int counter,
      List<ListFoodTransactionModel> listTransaction,
      List<ListFoodModel> foods}) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 30,
        ),
        _userProfile(data: data),
        SizedBox(
          height: 30,
        ),
        _statisticRow(context, people: counter, foods: counter),
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
        buildListOnProgress(context, list: listTransaction),
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
        buildFinishedOrder(foods: foods),
      ],
    );
  }

  Container buildFinishedOrder({List<ListFoodModel> foods}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 100),
      child: foods.length < 1
          ? Center(
              child: Text('Belum ada makanan terselesaikan'),
            )
          : ListView.separated(
              separatorBuilder: (context, index) {
                return TransparentDivider();
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foods.length,
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
                                foods[index].foodName,
                                style: TextStyling()..bold(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  foods[index].status == 'Terdonasikan'
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 10,
                                        )
                                      : Icon(
                                          Icons.close_rounded,
                                          color: Colors.redAccent,
                                          size: 10,
                                        ),
                                  Text(
                                    ' ${foods[index].status}',
                                    style: TextStyling(color: Colors.grey)
                                      ..small(),
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

  Container buildListOnProgress(BuildContext context,
      {List<ListFoodTransactionModel> list}) {
    return Container(
      height: MediaQuery.of(context).size.width / 4,
      width: MediaQuery.of(context).size.width,
      child: list.length < 1
          ? Center(child: Text('Belum ada makanan dalam proses'))
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
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
                          list[index].pathfoodphoto,
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
                              list[index].foodName,
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
                                  " ${list[index].jarak}" ?? ' -',
                                  style: TextStyling(color: Colors.grey)
                                    ..small(),
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
                                Flexible(
                                  child: Text(
                                    ' ${DateFormatter().hhmm(date: list[index].waktuPengambilan)}',
                                    style: TextStyling(color: Colors.grey)
                                      ..small(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
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

  Row _statisticRow(BuildContext context, {int people, int foods}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatisticContainer(context,
            imagePath: 'assets/Icon/icon_food.png',
            quantity: foods,
            title: 'Makanan yang telah dibagikan'),
        _buildStatisticContainer(context,
            imagePath: 'assets/Icon/icon_people.png',
            quantity: people,
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
                              style: TextStyling(color: Colors.grey)..normal(),
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
