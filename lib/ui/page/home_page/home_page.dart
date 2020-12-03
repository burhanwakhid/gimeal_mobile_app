import 'package:flutter/material.dart';
import 'package:gimeal/config/app.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/page/unggah_makanan_page/unggah_makanan_page.dart';
import 'package:gimeal/ui/widgets/FoodTileBig.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aplikasi Gimeal',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routers.unggahMakanan),
        child: Icon(Icons.add),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        children: [
          ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return FoodTileBig();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
