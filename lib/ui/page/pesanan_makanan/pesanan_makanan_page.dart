import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/core/helper/date_formatter.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/pesanan_makanan/cancel_pesanan_page.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:latlong/latlong.dart';

class PesananMakanan extends StatefulWidget {
//  final ListFoodModel data;
  final double lat;
  final double long;
  final String fotoUser;
  final String namaUser;
  final String hpUser;
  final String foodName;
  final DateTime waktuPenayangan;
  final String idPesanan;
  final String idMakanan;

  PesananMakanan({
//    @required this.data,
    this.idMakanan,
    this.lat,
    this.long,
    this.foodName,
    this.namaUser,
    this.hpUser,
    this.waktuPenayangan,
    this.fotoUser,
    this.idPesanan,
  });
  @override
  _PesananMakananState createState() => _PesananMakananState();
}

class _PesananMakananState extends State<PesananMakanan> {
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
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(
              this.widget.lat,
              this.widget.long,
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
                  this.widget.lat,
                  this.widget.long,
                ),
                width: 30.0,
                height: 30.0,
                builder: (context) => Container(
                    child:
                        Icon(Icons.location_pin, size: 50, color: Colors.red)),
              )
            ])
          ],
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/user%2${this.widget.fotoUser}.png?alt=media',
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
                          Text(
                            this.widget.idPesanan,
                            style: TextStyling()
                              ..big()
                              ..bold(),
                          ),
                          Text(
                            this.widget.namaUser,
                            style: TextStyling(color: Colors.grey)..normal(),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                                          date: this.widget.waktuPenayangan),
                                      style: TextStyling(color: Colors.grey)
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
                      onTap: () {},
                      name: 'Panggil',
                      color: Colors.white,
                    ),
                    RoundedSideButton(
                      onTap: () {
                        FlutterOpenWhatsapp.sendSingleMessage(
                            this.widget.hpUser,
//                            '+6285740226188',
                            'Hai ${this.widget.namaUser}, \n Saya ingin mengambil makanan *${this.widget.foodName}* yang ingin kamu bagikan di aplikasi *Gimeal*');
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNav(index: 1),
                        ),
                      );
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
                        idFood: this.widget.idMakanan,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Batalkan Pesanan',
                  style: TextStyling(
                      decoration: TextDecoration.underline, color: Colors.grey)
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
