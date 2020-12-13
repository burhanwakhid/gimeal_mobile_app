import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';

class CancelPesanan extends StatefulWidget {
  @override
  _CancelPesananState createState() => _CancelPesananState();
}

class _CancelPesananState extends State<CancelPesanan> {
  final List<String> listReason = [
    'Kondisi makanan yang tidak sesuai dengan gambar',
    'Tidak bisa menemukan lokasi pemberi donasi',
    'Informasi alamat tidak lengkap',
    'Pemberi donasi tidak dapat dihubungi',
    'Lainnya',
  ];

  String reason = '';

  Future<void> _showDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialogWidget(
              title: 'Pembatalan',
              desc: 'Batalkan pengambilan ?',
              textBtn1: 'Tidak',
              textBtn2: 'Batal',
              onTapBtn1: () {
                Navigator.pop(context);
              },
              onTapBtn2: () {
                Navigator.pushNamed(context, Routers.homePage);
              });
        });
  }

  @override
  void initState() {
    reason = listReason[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pembatalan',
          style: TextStyling(color: Colors.grey)
            ..big()
            ..bold(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: List<Widget>.generate(listReason.length, (index) {
                return RadioListTile(
                  value: listReason[index],
                  title: Text(
                    listReason[index],
                    style: TextStyling()..normal(),
                  ),
                  groupValue: reason,
                  onChanged: (newValue) {
                    setState(() {
                      reason = newValue;
                    });
                  },
                );
              }),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 8,
              ),
              child: Center(
                child: RaisedButton(
                  child: Text(
                    'Batalkan',
                    style: TextStyling(color: Colors.white)..huge(),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  onPressed: () {
                    this._showDialog();
                  },
                  color: kMainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(25),
                    right: Radius.circular(25),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
