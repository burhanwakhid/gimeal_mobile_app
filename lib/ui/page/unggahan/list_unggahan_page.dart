import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';
import 'package:gimeal/ui/widgets/no_result_widget.dart';

import '../../shared/styles.dart';

class ListUnggahanPage extends StatefulWidget {
  @override
  _ListUnggahanPageState createState() => _ListUnggahanPageState();
}

class _ListUnggahanPageState extends State<ListUnggahanPage> {
  Future<List<ListFoodTransactionModel>> _list;

  Future getListOrder() async {
    String idUser = await MainSharedPreferences().getIdUser();
    setState(() {
      _list = FireFoodTransactionService.getListFoodTransactionByPembuatMakanan(
          idUser);
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Unggahan',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10),
        children: [
          FutureBuilder<List<ListFoodTransactionModel>>(
            future: _list,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              } else if (snapshot.hasData) {
                return snapshot.data.length < 1
                    ? NoResult(context, message: 'Anda belum memesan makanan')
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _orderContainerTile(
                              context, snapshot.data[index]);
                        });
              } else {
                return NoResult(context, message: 'Anda belum memesan makanan');
              }
            },
          )
        ],
      ),
    );
  }

  Container _orderContainerTile(
      BuildContext context, ListFoodTransactionModel item) {
    return Container(
      height: MediaQuery.of(context).size.width / 4,
      padding: EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 9),
      decoration: BoxDecoration(
        // color: Color(0xffC3DE9B),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                item.pathfoodphoto,
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.foodName} ',
                  style: TextStyling()
                    ..normal()
                    ..copyWith(fontSize: 15)
                    ..bold(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.timer),
                    Text(
                      '${item.statusPemesanan} ',
                      style: TextStyling()..normal(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showMyDialog(item.idTransaction);
                })
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String idTrans) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomDialogWidget(
          title: 'Hapus',
          desc: 'Apakah anda yakin untuk menghapus unggahan?',
          textBtn1: 'Tidak',
          textBtn2: 'Hapus',
          onTapBtn1: () => Navigator.pop(context),
          onTapBtn2: () {
            FireFoodTransactionService.changeStatusFoodTransaction(
              idTrans,
              'deleted',
            ).then((value) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: 'Berhasil');
              getListOrder();
              print('sukses');
            }).catchError((onError) {
              Fluttertoast.showToast(msg: onError.toString());
            });
          },
        );
      },
    );
  }
}
