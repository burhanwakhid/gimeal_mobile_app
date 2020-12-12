import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String desc;
  final String textBtn1;
  final String textBtn2;
  final Function onTapBtn1;
  final Function onTapBtn2;

  const CustomDialogWidget(
      {Key key,
      @required this.title,
      @required this.desc,
      @required this.textBtn1,
      @required this.textBtn2,
      @required this.onTapBtn1,
      @required this.onTapBtn2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Center(child: Text('$title')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(
                child: Text(
              desc,
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                    onPressed: onTapBtn1,
                    child: Text('$textBtn1'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    )),
                RaisedButton(
                    onPressed: onTapBtn2,
                    child: Text('$textBtn2'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
