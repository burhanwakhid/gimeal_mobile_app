import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/shared/styles.dart';

class OnProgress extends StatefulWidget {
  @override
  _OnProgressState createState() => _OnProgressState();
}

class _OnProgressState extends State<OnProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Dalam Proses',
          style: TextStyling(color: Colors.grey)
            ..bold()
            ..huge(),
        ),
        actions: [
          Image.asset(
            'assets/Icon/icon_order.png',
            width: 40,
          ),
        ],
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
      height: MediaQuery.of(context).size.width / 2.6,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xffC3DE9B),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
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
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/1200px-RedDot_Burger.jpg',
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.width / 4,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Burger Yummy mantoel',
                style: TextStyling()
                  ..normal()
                  ..copyWith(fontSize: 15)
                  ..bold(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'Jl. Bhaskara Blok A no 6',
                style: TextStyling(color: Colors.grey)..normal(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                '16.00 - 18.00 pm',
                style: TextStyling(color: Colors.grey)..normal(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                '5 menit dari lokasi anda',
                style: TextStyling()..normal(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
