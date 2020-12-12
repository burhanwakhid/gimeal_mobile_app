import 'package:flutter/material.dart';
import 'package:gimeal/ui/widgets/custom_dialog_widget.dart';

import '../../shared/styles.dart';

class ListUnggahanPage extends StatefulWidget {
  @override
  _ListUnggahanPageState createState() => _ListUnggahanPageState();
}

class _ListUnggahanPageState extends State<ListUnggahanPage> {
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
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => _orderContainerTile(context),
          ),
        ],
      ),
    );
  }

  Container _orderContainerTile(BuildContext context) {
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
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/1200px-RedDot_Burger.jpg',
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
                  'Burger ',
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
                      'On Proccess ',
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
                  _showMyDialog();
                })
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
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
          onTapBtn2: () => Navigator.pop(context),
        );
      },
    );
  }
}
