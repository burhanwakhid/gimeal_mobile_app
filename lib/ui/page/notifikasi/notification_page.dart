import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';
import 'package:gimeal/ui/widgets/no_result_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int total = 2;
  Future<List<ListFoodTransactionModel>> _list;

  Future getListOrder() async {
    String idUser = await MainSharedPreferences().getIdUser();
    setState(() {
      _list = FireFoodTransactionService.getListNotification(idUser);
    });
  }

  @override
  void initState() {
    this.getListOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notifikasi',
            style: TextStyling(color: Colors.grey)
              ..bold()
              ..huge(),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<ListFoodTransactionModel>>(
          future: _list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            } else if (snapshot.hasData) {
              return snapshot.data.length < 1
                  ? NoResult(context, message: 'Anda belum memesan makanan')
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          color: Color(0xffC3DE9B).withOpacity(0.5),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                        item.pathfoodphoto,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.namaPemesan,
                                            style: TextStyling()
                                              ..big()
                                              ..bold(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          TransparentDivider(),
                                          Text(
                                            'Ingin mengambil makanan anda',
                                            style: TextStyling()..normal(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          TransparentDivider(),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_city_outlined,
                                                size: 12,
                                              ),
                                              Text(
                                                '  ${item.jarak}',
                                                style: TextStyling()..normal(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          TransparentDivider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              RaisedButton(
                                                color: kMainColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    left: Radius.circular(50),
                                                    right: Radius.circular(50),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  print('Terima Permintaan');
                                                  FireFoodTransactionService
                                                      .changeStatusFoodTransaction(
                                                    item.idTransaction,
                                                    'accepted',
                                                  ).then((value) {
                                                    Fluttertoast.showToast(
                                                        msg: 'Berhasil');
                                                  }).catchError((onError) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            onError.toString());
                                                  });
                                                },
                                                child: Text(
                                                  'Terima',
                                                  style: TextStyling(
                                                      color: Colors.white)
                                                    ..small(),
                                                ),
                                              ),
                                              RaisedButton(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    left: Radius.circular(50),
                                                    right: Radius.circular(50),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  print('aksi tolak pesanan');
                                                  _showDialog(context,
                                                      item.idTransaction);
                                                },
                                                child: Text(
                                                  'Tolak',
                                                  style: TextStyling(
                                                      color: Colors.grey)
                                                    ..small(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return NoResult(context, message: 'Anda belum memesan makanan');
            }
          },
        ));
  }

  Future<bool> _showDialog(BuildContext contextes, idTrans) {
    return showDialog(
        context: contextes,
        builder: (context) {
          return CustomDialogWidget(
              title: 'Tolak Pesanan',
              desc: 'Tolak Pesanan ?',
              textBtn1: 'Tidak',
              textBtn2: 'Tolak',
              onTapBtn1: () {
                Navigator.pop(context, false);
              },
              onTapBtn2: () {
                FireFoodTransactionService.changeStatusFoodTransaction(
                  idTrans,
                  'rejected',
                ).then((value) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'Berhasil');
                  getListOrder();
                  print('sukses');
                }).catchError((onError) {
                  Fluttertoast.showToast(msg: onError.toString());
                });
              });
        });
  }
}
