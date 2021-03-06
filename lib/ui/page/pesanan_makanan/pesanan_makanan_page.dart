import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/helper/date_formatter.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_service.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/pesanan_makanan/cancel_pesanan_page.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class PesananMakanan extends StatefulWidget {
  final String idPesanan;

  PesananMakanan({
    @required this.idPesanan,
  });
  @override
  _PesananMakananState createState() => _PesananMakananState();
}

class _PesananMakananState extends State<PesananMakanan> {
  Future<ListFoodTransactionModel> _data;

  Future getTransactionDetail() async {
    _data = FireFoodTransactionService.getDetailTransaction(widget.idPesanan);
  }

  @override
  void initState() {
    this.getTransactionDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: kMainColor,
        child: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/onProgress');
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<ListFoodTransactionModel>(
          future: _data,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Center(child: LinearProgressIndicator());
                break;
              case ConnectionState.waiting:
                return Center(child: LinearProgressIndicator());
                break;
              case ConnectionState.none:
                return Center(child: LinearProgressIndicator());
                break;
              case ConnectionState.done:
                return FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      snapshot.data.lokasiMakanan.latitude,
                      snapshot.data.lokasiMakanan.longitude,
                    ),
                    zoom: 15,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(markers: [
                      Marker(
                        point: LatLng(
                          snapshot.data.lokasiMakanan.latitude,
                          snapshot.data.lokasiMakanan.longitude,
                        ),
                        width: 30.0,
                        height: 30.0,
                        builder: (context) => Container(
                            child: Icon(Icons.location_pin,
                                size: 50, color: Colors.red)),
                      )
                    ])
                  ],
                );
                break;
              default:
                return LinearProgressIndicator();
                break;
            }
          },
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return _bottomSheet();
                });
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 80,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CenterBoldDivider(),
                CenterBoldDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return FutureBuilder<ListFoodTransactionModel>(
      future: this._data,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container();
            break;
          case ConnectionState.none:
            return Container();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            return BottomSheet(
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CenterBoldDivider(),
                            CenterBoldDivider(),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/user%2${snapshot.data.fotoPembuat}.png?alt=media',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.foodName,
                                    style: TextStyling()
                                      ..big()
                                      ..bold(),
                                  ),
                                  TransparentDivider(),
                                  Text(
                                    snapshot.data.namaPembuat,
                                    style: TextStyling(color: Colors.grey)
                                      ..normal(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  TransparentDivider(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.av_timer,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Text(
                                              DateFormatter().formatDate(
                                                  date: snapshot
                                                      .data.waktuPenayangan),
                                              style: TextStyling(
                                                  color: Colors.grey)
                                                ..normal(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedSideButton(
                              onTap: () {
                                String _phone = snapshot.data.hpPembuat;
                                if (_phone[0] == '0') {
                                  _phone = _phone.replaceRange(0, 1, '+62');
                                }
                                launch("tel://$_phone");
                              },
                              name: 'Panggil',
                              color: Colors.white,
                            ),
                            RoundedSideButton(
                              onTap: () {
                                String _phone = snapshot.data.hpPembuat;
                                if (_phone[0] == '0') {
                                  _phone = _phone.replaceRange(0, 1, '+62');
                                }
                                FlutterOpenWhatsapp.sendSingleMessage(_phone,
                                    'Hai ${snapshot.data.namaPembuat}, \n Saya ingin mengambil makanan *${snapshot.data.foodName}* yang ingin kamu bagikan di aplikasi *Gimeal*');
                              },
                              name: 'Pesan',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedSideButton(
                            name: 'Selesai',
                            color: kMainColor,
                            horizontalPadding: 80.0,
                            textColor: Colors.white,
                            onTap: snapshot.data.statusPemesanan != 'accepted'
                                ? () {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Pesanan menunggu konfirmasi pemilik makanan :)',
                                        gravity: ToastGravity.CENTER);
                                  }
                                : () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return RatingDialog(
                                            data: snapshot.data,
                                          );
                                        });
                                  },
                          ),
                        ],
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CancelPesanan(
                                idTransaction: this.widget.idPesanan,
                                idFood: snapshot.data.idFood,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Batalkan Pesanan',
                          style: TextStyling(
                              decoration: TextDecoration.underline,
                              color: Colors.grey)
                            ..normal(),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onClosing: () {},
              onDragStart: (value) {
                Navigator.of(context).pop();
              },
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
            );
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }
}

class RatingDialog extends StatefulWidget {
  final ListFoodTransactionModel data;

  RatingDialog({
    this.data,
  });

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rates = 3;

  _funcNilai() {
    FoodServices.addRating(
        widget.data.idFood, widget.data.idTransaction, rates.toInt());
    FireFoodTransactionService.changeStatusFoodTransaction(
      widget.data.idTransaction,
      'done',
    ).then((_) {
      Navigator.pushNamed(
        context,
        Routers.homePage,
      ).catchError((onError) {
        print(onError);
      });
    });
  }

  _funcNantiSaja() {
    FireFoodTransactionService.changeStatusFoodTransaction(
      widget.data.idTransaction,
      'done',
    ).then((_) {
      Navigator.pushNamed(
        context,
        Routers.homePage,
      ).catchError((onError) {
        print(onError);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: MediaQuery.of(context).size.width / 4.5,
                    height: MediaQuery.of(context).size.width / 4.5,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.foodName,
                        style: TextStyling()
                          ..huge()
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50),
                                right: Radius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              print('nanti saja');
                              _funcNantiSaja();
                            },
                            child: Text(
                              'Nanti saja',
                              style: TextStyling(color: Colors.grey)..bold(),
                            ),
                          ),
                          RaisedButton(
                            color: kMainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50),
                                right: Radius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              print(widget.data.idTransaction);
                              _funcNilai();
                            },
                            child: Text(
                              'Nilai',
                              style: TextStyling(color: Colors.white)..bold(),
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
      ),
    );
  }
}

class RoundedSideButton extends StatelessWidget {
  const RoundedSideButton({
    Key key,
    this.name,
    this.color,
    this.horizontalPadding,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  final String name;
  final Color color;
  final double horizontalPadding;
  final Color textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: horizontalPadding ?? 50),
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
      ),
      child: Text(
        name,
        style: TextStyling(color: textColor ?? Colors.black45)
          ..bold()
          ..normal(),
      ),
      color: color ?? Colors.white,
    );
  }
}

class CenterBoldDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double indent = MediaQuery.of(context).size.width / 2 - 50;
    return Divider(
      thickness: 4,
      indent: indent,
      endIndent: indent,
    );
  }
}
