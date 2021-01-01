import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_service.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/core/store/food_transaction_store.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:gimeal/ui/widgets/rating_display.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  Future<List<ListFoodTransactionModel>> _transactions;

  getData() async {
    String idUser = await MainSharedPreferences().getIdUser();
    print('id User : $idUser');
    setState(() {
      _transactions = FireFoodTransactionService.getUnratedOrder(idUser);
    });
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Penilaian',
          style: TextStyling(color: Colors.grey)..bold(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder<List<ListFoodTransactionModel>>(
            future: _transactions,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return LinearProgressIndicator();
                  break;
                case ConnectionState.active:
                  return LinearProgressIndicator();
                  break;
                case ConnectionState.none:
                  return LinearProgressIndicator();
                  break;
                case ConnectionState.done:
                  if (snapshot.data.length < 1) {
                    return Center(
                      child: Text(
                        'Belum ada penilaian , silakan lakukan transaksi donasi makanan',
                        style: TextStyling(
                          color: Colors.grey,
                        )..big(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return RatingTile(
                          data: snapshot.data[index],
                          onRateDone: () {
                            this.getData();
                          },
                        );
                      },
                    );
                  }

                  break;
                default:
                  return LinearProgressIndicator();
                  break;
              }
            }),
      ),
    );
  }

  Widget _containerTile(BuildContext context, ListFoodTransactionModel data) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        color: Color(0xffC3DE9B).withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  data.pathfoodphoto,
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  fit: BoxFit.cover,
                ),
              ),
              VerticalDivider(
                color: Colors.transparent,
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.foodName,
                      style: TextStyling()
                        ..big()
                        ..bold()
                        ..copyWith(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
//                    TransparentDivider(),
                    Text(
                      data.namaPembuat,
                      style: TextStyling()..normal(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
//                    TransparentDivider(),
                    Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Icon/checkmark-filled.png',
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          '  Terdonasikan',
                          style: TextStyling()..normal(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
//                    TransparentDivider(),
                    RatingDisplay(
                      value: 0,
                      size: 22,
                    ),
                    TransparentDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: RaisedButton(
                            color: kMainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50),
                              right: Radius.circular(50),
                            )),
                            onPressed: () {
                              print('aksi beri penilaian');
                            },
                            child: Text(
                              'Nilai',
                              style: TextStyling(color: Colors.white)..bold(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingTile extends StatefulWidget {
  final ListFoodTransactionModel data;
  final Function onRateDone;

  RatingTile({this.data, this.onRateDone});

  @override
  _RatingTileState createState() => _RatingTileState();
}

class _RatingTileState extends State<RatingTile> {
  double rates = 3;

  Future _rateFood() async {
    FoodServices.addRating(
            widget.data.idFood, widget.data.idTransaction, rates.toInt())
        .then((value) {
      Fluttertoast.showToast(msg: 'Rating berhasil ditambahkan');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      color: Color(0xffC3DE9B).withOpacity(0.9),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                widget.data.pathfoodphoto,
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                fit: BoxFit.cover,
              ),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.idTransaction,
                    style: TextStyling()
                      ..big()
                      ..bold()
                      ..copyWith(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    widget.data.namaPembuat,
                    style: TextStyling()..normal(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/Icon/checkmark-filled.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        '  Terdonasikan',
                        style: TextStyling()..normal(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  RatingBar.builder(
                    itemSize: 25,
                    itemCount: 5,
                    allowHalfRating: false,
                    tapOnlyMode: true,
                    direction: Axis.horizontal,
                    initialRating: rates,
                    minRating: 1.0,
                    unratedColor: Colors.amber.shade100,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (value) {
                      setState(() {
                        rates = value;
                      });
                    },
                  ),
                  TransparentDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: kMainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50),
                          )),
                          onPressed: () {
                            this._rateFood().then((value) {
                              this.widget.onRateDone();
                            });
                          },
                          child: Text(
                            'Nilai',
                            style: TextStyling(color: Colors.white)..bold(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
