import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/rating_display.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int length = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Penilaian',
          style: TextStyling(color: Colors.grey)..bold(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: length < 1
            ? Center(
                child: Text(
                  'Belum ada penilaian , silakan lakukan transaksi donasi makanan',
                  style: TextStyling(
                    color: Colors.grey,
                  )..big(),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: length,
                itemBuilder: (context, index) {
                  return _containerTile(context);
                },
              ),
      ),
    );
  }

  Widget _containerTile(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
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
                      'https://cdn.idntimes.com/content-images/post/20170721/resep-rawon-98d900d3e27085f192f57e3167b4d834_600x400.jpeg',
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rawon Lebaran',
                          style: TextStyling()
                            ..big()
                            ..bold()
                            ..copyWith(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          'Nabilah JKT666',
                          style: TextStyling()..normal(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/Icon/checkmark-filled.png',
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              '  Terdonasikan',
                              style: TextStyling()..normal(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        RatingDisplay(
                          value: 0,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    color: kMainColor,
                    padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: MediaQuery.of(context).size.width / 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(50),
                      right: Radius.circular(50),
                    )),
                    onPressed: () {
                      print('aksi beri penilaian');
                    },
                    child: Text(
                      'Nilai',
                      style: TextStyling(color: Colors.white)..bold(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
