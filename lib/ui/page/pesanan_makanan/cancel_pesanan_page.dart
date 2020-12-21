import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class CancelPesanan extends StatefulWidget {
  final String idTransaction;
  final String idFood;

  CancelPesanan({
    this.idTransaction,
    this.idFood,
  });
  @override
  _CancelPesananState createState() => _CancelPesananState();
}

class _CancelPesananState extends State<CancelPesanan> {
  Future cancelTransaction(BuildContext context) async {
    await FireFoodTransactionService.batalkanPesanan(
            this.widget.idTransaction, this.widget.idFood)
        .then((value) {
      Navigator.pushNamed(context, '/onProgress');
    });
  }

  final List<String> listReason = [
    'Kondisi makanan yang tidak sesuai dengan gambar',
    'Tidak bisa menemukan lokasi pemberi donasi',
    'Informasi alamat tidak lengkap',
    'Pemberi donasi tidak dapat dihubungi',
    'Lainnya',
  ];

  String reason = '';

  Future<bool> _showDialog(BuildContext contextes) {
    return showDialog(
        context: contextes,
        builder: (context) {
          return CustomDialogWidget(
              title: 'Pembatalan',
              desc: 'Batalkan pengambilan ?',
              textBtn1: 'Tidak',
              textBtn2: 'Batal',
              onTapBtn1: () {
                Navigator.pop(context, false);
              },
              onTapBtn2: () {
                Navigator.pop(context, true);
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
    return ProgressHUD(child: Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.grey,
            ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);

                        await _showDialog(context).then((value) async {
                          if (value) {
                            progress.show();
                            await cancelTransaction(context).then((value) {
                              progress.dismiss();
                            });
                          }
                        });
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
      },
    ));
  }
}
