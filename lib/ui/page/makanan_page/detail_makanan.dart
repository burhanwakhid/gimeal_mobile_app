import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/store/food_transaction_store.dart';
import 'package:gimeal/ui/page/pesanan_makanan/pesanan_makanan_page.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:latlong/latlong.dart';

class DetailMakanan extends StatefulWidget {
  final ListFoodModel listFoodModel;

  const DetailMakanan({Key key, this.listFoodModel}) : super(key: key);
  // DetailMakanan({
  //   this.listFoodModel,
  // });
  @override
  _DetailMakananState createState() => _DetailMakananState();
}

class _DetailMakananState extends State<DetailMakanan> {
  final FoodTransactionStore _foodTransactionStore = FoodTransactionStore();
  bool _inLoading = false;
  _doLoading() {
    setState(() {
      _inLoading = true;
    });
  }

  _endLoading() {
    setState(() {
      _inLoading = false;
    });
  }

  Future _orderFood() async {
    _doLoading();
    await _foodTransactionStore
        .saveTransaction(this.widget.listFoodModel)
        .then((value) {
      _endLoading();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PesananMakanan(
            data: this.widget.listFoodModel,
          ),
        ),
      );
    }).catchError(() {
      _endLoading();
      Fluttertoast.showToast(msg: 'Error saat membuat pesanan');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 70,
        width: MediaQuery.of(context).size.width - 100,
        child: RaisedButton(
          onPressed: () {
            //Todo action pesan makanan
            _orderFood();
          },
          color: kMainColor,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(50),
              right: Radius.circular(50),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ambil',
                style: TextStyling(color: Colors.white)
                  ..huge()
                  ..bold(),
              ),
              Text(
                this.widget.listFoodModel.jarak,
                style: TextStyling(color: Colors.white)
                  ..huge()
                  ..bold(),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          this.widget.listFoodModel.foodName,
          overflow: TextOverflow.ellipsis,
          style: TextStyling()
            ..big()
            ..bold(),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Material(
            elevation: 2,
            child: Image.network(
              '${this.widget.listFoodModel.pathFoodPhoto} ',
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/user%2${this.widget.listFoodModel.fotoUser}.png?alt=media',
                ),
              ),
              title: Text(
                this.widget.listFoodModel.namaUser,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                this.widget.listFoodModel.waktuPengambilan.toString(),
                style: kCardSubtitleTextStyle,
              ),
              trailing: Text(
                this.widget.listFoodModel.jarak,
                style: kCardSubtitleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _foodInfoTile(
                    name: 'Jumlah Makanan',
                    value: this.widget.listFoodModel.jumlahFood.toString()),
                _foodInfoTile(
                    name: 'Deskripsi', value: this.widget.listFoodModel.desc),
                _foodInfoTile(
                    name: 'Alamat lengkap',
                    value: this.widget.listFoodModel.alamatLengkap),
                _foodInfoTile(name: 'Lokasi Penjemputan', value: ''),
              ],
            ),
          ),
          Container(
            height: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(
                  this.widget.listFoodModel.latitude,
                  this.widget.listFoodModel.longitude,
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
                    width: 30.0,
                    height: 30.0,
                    point: LatLng(
                      this.widget.listFoodModel.latitude,
                      this.widget.listFoodModel.longitude,
                    ),
                    builder: (ctx) => Container(
                        child: Icon(Icons.location_pin,
                            size: 50, color: Colors.red)),
                  )
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _foodInfoTile({
    @required String name,
    @required String value,
  }) {
    return ListTile(
      title: Text(
        '$name :',
        style: TextStyling()..bold(),
      ),
      subtitle: Text(
        value,
        style: kCardSubtitleTextStyle,
      ),
    );
  }
}
