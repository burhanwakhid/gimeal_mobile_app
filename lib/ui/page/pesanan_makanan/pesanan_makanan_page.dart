import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/shared/styles.dart';

class PesananMakanan extends StatefulWidget {
  @override
  _PesananMakananState createState() => _PesananMakananState();
}

class _PesananMakananState extends State<PesananMakanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: kMainColor,
        child: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlutterMap(
          options: MapOptions(),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                builder: (ctx) => Container(
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
              CenterBoldDivider(),
              CenterBoldDivider(),
              ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/474x/9c/e5/7f/9ce57f4e94275efb3a4a39c69297a9e4.jpg',
                  ),
                ),
                title: Text(
                  'Juna Hermawan',
                  style: TextStyling()
                    ..huge()
                    ..bold(),
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      'Jl Bhaskara nomor 2 jauh',
                      style: TextStyling(color: Colors.grey)..big(),
                    )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.av_timer,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Text(
                          '16.00 - 18.00 PM',
                          style: TextStyling(color: Colors.grey)..big(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedSideButton(
                      name: 'Panggil',
                      color: Colors.white,
                    ),
                    RoundedSideButton(
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
                  ),
                ],
              ),
              FlatButton(
                onPressed: () {},
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
  }) : super(key: key);

  final String name;
  final Color color;
  final double horizontalPadding;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      padding: EdgeInsets.symmetric(
          vertical: 15, horizontal: horizontalPadding ?? 50),
      onPressed: () {},
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
          ..big(),
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