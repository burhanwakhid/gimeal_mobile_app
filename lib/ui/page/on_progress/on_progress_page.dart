import 'package:flutter/material.dart';
import 'package:gimeal/core/helper/date_formatter.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/ui/page/pesanan_makanan/pesanan_makanan_page.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/no_result_widget.dart';

class OnProgress extends StatefulWidget {
  @override
  _OnProgressState createState() => _OnProgressState();
}

class _OnProgressState extends State<OnProgress> {
  Future<List<ListFoodTransactionModel>> _list;

  Future getListOrder() async {
    String idUser = await MainSharedPreferences().getIdUser();
    setState(() {
      _list =
          FireFoodTransactionService.getListFoodTransactionByPemesan(idUser);
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
        backgroundColor: Colors.white,
        title: Text(
          'Dalam Proses',
          style: TextStyling(color: Colors.grey)
            ..bold()
            ..huge(),
        ),
        actions: [
          Image.asset(
            'assets/Icon/icon_order.png',
            width: 40,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getListOrder,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<List<ListFoodTransactionModel>>(
            future: _list,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              } else if (snapshot.hasData) {
                return snapshot.data.length < 1
                    ? NoResult(context, message: 'Anda belum memesan makanan')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: _orderContainerTile(
                                context, snapshot.data[index]),
                          );
                        },
                      );
              } else {
                return NoResult(context, message: 'Anda belum memesan makanan');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _orderContainerTile(
      BuildContext context, ListFoodTransactionModel data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PesananMakanan(
//            data: this.widget.listFoodModel,
              idMakanan: data.idFood,
              idPesanan: data.idTransaction,
              foodName: data.foodName,
              fotoUser: data.fotoPembuat,
              lat: data.lokasiMakanan.latitude,
              long: data.lokasiMakanan.longitude,
              namaUser: data.namaPembuat,
              hpUser: data.hpPembuat,
              waktuPenayangan: data.waktuPenayangan,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        height: MediaQuery.of(context).size.width / 2.6,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xffC3DE9B).withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
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
                data.pathfoodphoto,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Text(
                    data.alamatLengkap,
                    style: TextStyling(color: Colors.grey)..normal(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    DateFormatter().formatDate(date: data.waktuPengambilan),
                    style: TextStyling(color: Colors.grey)..normal(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    data.statusPemesanan,
                    style: TextStyling()..normal(),
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
  }
}
