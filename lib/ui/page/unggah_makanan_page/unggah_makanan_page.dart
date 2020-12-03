import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

class UnggahMakananPage extends StatefulWidget {
  @override
  _UnggahMakananPageState createState() => _UnggahMakananPageState();
}

class _UnggahMakananPageState extends State<UnggahMakananPage> {
  TextEditingController waktuPengambilanCont = TextEditingController();
  TextEditingController namaMakananCont = TextEditingController();
  TextEditingController deskripsiCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();
  TextEditingController alamatCont = TextEditingController();  


  double jmlMakanan = 1;
  DateTime waktuPengambilan;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  MapController mapController;

  LatLng currentLocation;

  List<LatLng> tappedPoints = [];

  LatLng pickedLocation;
  bool isPicked = false;

  File _imageFood;
  final picker = ImagePicker();

  @override
  void initState() {
    // _getPosition();
    mapController = MapController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future<void> _getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    mapController.move(LatLng(position.latitude, position.longitude), 17);
    currentLocation = LatLng(position.latitude, position.longitude);
    _handleTap(LatLng(position.latitude, position.longitude));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFood = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 30.0,
        height: 30.0,
        point: latlng,
        builder: (ctx) => Container(
            child: Icon(Icons.location_pin, size: 50, color: Colors.red)),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unggah Makanan',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (_imageFood == null)
                    ? Container(
                        width: size.width / 3,
                        height: size.height / 10,
                        decoration: BoxDecoration(
                            // color: Theme.of(context).accentColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: RaisedButton(
                          onPressed: () {
                            // _showTimePicker();
                            getImage();
                          },
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                              ),
                              Text(
                                'Pilih Foto',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.file(
                                _imageFood,
                                fit: BoxFit.cover,
                                width: size.width,
                                height: size.height / 3,
                              )),
                          OutlineButton(
                            onPressed: () {
                              getImage();
                            },
                            child: Text('Retake Photo'),
                          )
                        ],
                      ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Nama Makanan')),
                ),
                Container(
                  width: size.width / 1.2,
                  height: size.height / 18,
                  child: TextFormField(
                    controller: namaMakananCont,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.grey),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      hintText: "Masukan nama makanan",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Color(0xFF757575)),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Pilih Jumlah Makanan')),
                ),
                Slider(
                  value: jmlMakanan,
                  onChanged: (val) {
                    setState(() {
                      jmlMakanan = val;
                    });
                  },
                  min: 1,
                  max: 10,
                  autofocus: true,
                  divisions: 9,
                  label: jmlMakanan.round().toString(),
                ),
                Text(
                  'Jumlah makanan: ${jmlMakanan.round().toString()}',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Container(
                  width: size.width / 1.2,
                  height: size.height / 18,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: TextFormField(
                    controller: noteCont,
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      suffixIcon: Icon(Icons.note),
                      // labelText: "Email, or Phone Number",
                      hintText: "Add notes",
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Color(0xFF757575)),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Deskripsi')),
                ),
                TextFormField(
                  controller: deskripsiCont,
                  maxLines: 4,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Deskripsi...',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Color(0xFF757575)),
                      gapPadding: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Waktu Pengambilan')),
                ),
                GestureDetector(
                  onTap: () async {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      onConfirm: (val) {
                        setState(() {
                          waktuPengambilan = val;
                          waktuPengambilanCont.text =
                              val.hour.toString() + ':' + val.minute.toString();
                        });
                      },
                      locale: LocaleType.id,
                    );
                  },
                  child: AbsorbPointer(
                    child: Container(
                      width: size.width / 1.2,
                      height: size.height / 18,
                      child: TextFormField(
                        controller: waktuPengambilanCont,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Wajib diisi';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.grey),
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintText: "Waktu pengambilan",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Color(0xFF757575)),
                            gapPadding: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Waktu Penayangan')),
                ),
                Container(
                  width: size.width / 1.2,
                  height: size.height / 18,
                  child: DropdownButtonFormField(
                      itemHeight: 50,
                      hint: Text(
                        'Pilih Waktu Penayangan',
                        style: kCardSubtitleTextStyle,
                      ),
                      elevation: 4,
                      isDense: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 8, right: 0),
                        isCollapsed: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 15,
                        ),
                      ),
                      validator: (val) {
                        if (val == null) {
                          return 'Wajib diisi';
                        }
                        return null;
                      },
                      // value: listDropdownSymtomps[0],
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            '1',
                            style: kCardSubtitleTextStyle,
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            '2',
                            style: kCardSubtitleTextStyle,
                          ),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            '3',
                            style: kCardSubtitleTextStyle,
                          ),
                          value: 3,
                        )
                      ],
                      onChanged: (val) {
                        // setState(() {
                        //   keluhanType = val;
                        // });
                        FocusScope.of(context).requestFocus(FocusNode());
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Alamat Lengkap')),
                ),
                Container(
                  width: size.width / 1.2,
                  height: size.height / 18,
                  child: TextFormField(
                    controller: alamatCont,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.grey),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      hintText: "Masukan Alamat Lengkap Anda",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Color(0xFF757575)),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Lokasi Anda')),
                ),
                Container(
                  width: size.width,
                  height: size.height / 1.7,
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                            center: currentLocation == null
                                ? LatLng(-7.250445, 112.768845)
                                : currentLocation,
                            zoom: 13.0,
                            onTap: _handleTap),
                        layers: [
                          TileLayerOptions(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c']),
                          MarkerLayerOptions(markers: markers)
                        ],
                      ),
                      (markers.isNotEmpty)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    pickedLocation = currentLocation;
                                  });
                                },
                                child: Chip(
                                  avatar: Icon(Icons.location_pin,
                                      color: Colors.white),
                                  label: Text(
                                    'Setel sebagai lokasi',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                ),
                              ),
                            )
                          : Container(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                child: IconButton(
                              onPressed: () {
                                _getPosition();
                              },
                              icon: Icon(Icons.location_city),
                            )),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: pickedLocation != null
                          ? Text(
                              'Titik Lokasi yang anda pilih:\n  ${pickedLocation.latitude} & ${pickedLocation.longitude}')
                          : Text('Anda belum memilih titik lokasi anda')),
                ),
                SizedBox(height: 20),
                Container(
                  width: size.width / 2.3,
                  child: RaisedButton(
                    onPressed: () async {
                      // Navigator.pushNamed(context, Routers.registerPage);
                    },
                    child: Text(
                      'Unggah',
                      style: kSubtitleStyle.copyWith(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  void _handleTap(LatLng latlng) {
    setState(() {
      tappedPoints.clear();
      tappedPoints.add(latlng);
      currentLocation = latlng;
    });
  }
}

