import 'package:flutter/material.dart';

Widget NoResult(
  BuildContext context, {
  String message,
}) {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/Illustrasi/ilustrasi_5.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
          Text('$message'),
        ],
      ),
    ),
  );
}
