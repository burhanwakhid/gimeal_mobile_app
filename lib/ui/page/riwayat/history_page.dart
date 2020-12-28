import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gimeal/core/helper/date_formatter.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:gimeal/ui/widgets/no_result_widget.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int total = 3;

  Future<List<ListFoodTransactionModel>> _list;
  var iduser = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var id = await MainSharedPreferences().getIdUser();
    setState(() {
      iduser = id;
      _list = FireFoodTransactionService.getRiwayatTransaction(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
          'Riwayat',
          style: TextStyling(color: Colors.grey),
        ),
      ),
      // body: total < 1 ? buildError(context) : _buildListHistory(),
      body: FutureBuilder<List<ListFoodTransactionModel>>(
        future: _list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          } else if (snapshot.hasData) {
            return snapshot.data.length < 1
                ? NoResult(context, message: 'Anda belum memesan makanan')
                : _buildListHistory(snapshot.data);
          } else {
            return NoResult(context, message: 'Anda belum memesan makanan');
          }
        },
      ),
    );
  }

  Center buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Illustrasi/ilustrasi_6.png',
            height: MediaQuery.of(context).size.width - 100,
          ),
          Text(
            'Anda belum melakukan donasi makanan dan mengambil makanan',
            style: TextStyling(color: Colors.grey)
              ..big()
              ..bold(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  ListView _buildListHistory(List<ListFoodTransactionModel> items) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: this.total,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 4,
          child: Container(
//            height: MediaQuery.of(context).size.width / 2.6,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
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
                    item.pathfoodphoto,
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.foodName,
                        style: TextStyling()
                          ..big()
                          ..bold(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      TransparentDivider(),
                      Text(
                        (item.idPembuatMakanan == iduser)
                            ? 'telah disumbangkan kepada ${item.namaPemesan}'
                            : 'Anda telah mengambil makaanan dari ${item.namaPembuat}',
                        style: TextStyling(color: Colors.grey)..normal(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      TransparentDivider(),
                      Text(
                        DateFormatter().formatDate(date: item.createdAt),
                        style: TextStyling(color: Colors.grey)..normal(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
