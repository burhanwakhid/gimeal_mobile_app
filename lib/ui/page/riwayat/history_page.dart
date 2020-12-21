import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gimeal/core/helper/date_formatter.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int total = 3;
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
      body: total < 1
          ? Center(
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
            )
          : _buildListHistory(),
    );
  }

  ListView _buildListHistory() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: this.total,
      itemBuilder: (context, index) {
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
                    'https://cdn.idntimes.com/content-images/post/20170919/yam10-dcc58c472dc768b1696903c52d104d20_600x400.jpg',
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
                        'Ayam Bakar',
                        style: TextStyling()
                          ..big()
                          ..bold(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      TransparentDivider(),
                      Text(
                        'Telah disumbangkan kepada Budi Miredo',
                        style: TextStyling(color: Colors.grey)..normal(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      TransparentDivider(),
                      Text(
                        DateFormatter().formatDate(date: DateTime.now()),
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
