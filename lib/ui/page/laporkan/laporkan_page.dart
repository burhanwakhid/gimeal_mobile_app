import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LaporkanPage extends StatefulWidget {
  @override
  _LaporkanPageState createState() => _LaporkanPageState();
}

class _LaporkanPageState extends State<LaporkanPage> {
  String value = 'Memberikan deskripsi palsu pada unggahan makanan';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Laporkan',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: () async {
              await Future.delayed(Duration(seconds: 1));
              Fluttertoast.showToast(msg: 'Berhasil');
            },
            child: Text(
              'LAPORKAN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile(
              title: Text('Memberikan deskripsi palsu pada unggahan makanan'),
              value: 'Memberikan deskripsi palsu pada unggahan makanan',
              groupValue: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            RadioListTile(
              title: Text('Memberikan makanan yang tidak layak makan'),
              value: 'Memberikan makanan yang tidak layak makan',
              groupValue: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            RadioListTile(
              title: Text(
                  'Melakukan tindakan yang tidak beretika ketika melakukan donasi'),
              value:
                  'Melakukan tindakan yang tidak beretika ketika melakukan donasi',
              groupValue: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            RadioListTile(
              title: Text('Melampirkan alamat palsu pada profil pengguna'),
              value: 'Melampirkan alamat palsu pada profil pengguna',
              groupValue: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            RadioListTile(
              title: Text('lainnya'),
              value: 'lainnya',
              groupValue: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
