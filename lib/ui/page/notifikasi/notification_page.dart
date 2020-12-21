import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:gimeal/ui/widgets/no_result_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int total = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Notifikasi',
          style: TextStyling(color: Colors.grey)
            ..bold()
            ..huge(),
        ),
        backgroundColor: Colors.white,
      ),
      body: total < 1
          ? Center(
              child: Text(
                'Belum ada notifikasi masuk',
                style: TextStyling(color: Colors.grey)
                  ..bold()
                  ..big(),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: total,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  color: Color(0xffC3DE9B).withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                'https://i.pinimg.com/474x/9c/e5/7f/9ce57f4e94275efb3a4a39c69297a9e4.jpg',
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nabilah JKT666',
                                    style: TextStyling()
                                      ..big()
                                      ..bold(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  TransparentDivider(),
                                  Text(
                                    'Ingin mengambil makanan anda',
                                    style: TextStyling()..normal(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  TransparentDivider(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_city_outlined,
                                        size: 12,
                                      ),
                                      Text(
                                        '  1,2 km',
                                        style: TextStyling()..normal(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  TransparentDivider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RaisedButton(
                                        color: kMainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50),
                                          ),
                                        ),
                                        onPressed: () {
                                          print('Terima Permintaan');
                                        },
                                        child: Text(
                                          'Terima',
                                          style:
                                              TextStyling(color: Colors.white)
                                                ..small(),
                                        ),
                                      ),
                                      RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50),
                                          ),
                                        ),
                                        onPressed: () {
                                          print('aksi tolak pesanan');
                                        },
                                        child: Text(
                                          'Tolak',
                                          style: TextStyling(color: Colors.grey)
                                            ..small(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
