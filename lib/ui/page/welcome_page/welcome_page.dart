import 'package:flutter/material.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/ui/shared/styles.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: size.width,
          height: size.height / 1.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
            child: Column(
              children: [
                Text('Hello!', style: kTitleStyle),
                SizedBox(height: 10,),
                Text(
                  'Tempat terbaik untuk mendapatkan makanan dan berbagi makanan dengan orang lain.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25,),
                Container(
                  width: size.width / 2.3,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Masuk',
                      style: kSubtitleStyle.copyWith(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: size.width / 2.3,
                  child: RaisedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, Routers.registerPage);
                    },
                    child: Text(
                      'Daftar',
                      style: kSubtitleStyle.copyWith(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  
                ),
                SizedBox(height: 10,),
                Container(
                  width: size.width / 2.3,
                  child: RaisedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, Routers.unggahMakanan);
                    },
                    child: Text(
                      'Test',
                      style: kSubtitleStyle.copyWith(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
