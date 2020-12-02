import 'package:flutter/material.dart';
import 'package:gimeal/config/app.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/widgets/FoodTileBig.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      bottomNavigationBar: BottomNav(),
    );
  }

  ListView _body() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      children: [
        _listFood(),
      ],
    );
  }

  ListView _listFood() {
    return ListView.separated(
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
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text(
        'Aplikasi Gimeal',
      ),
    );
  }
}
