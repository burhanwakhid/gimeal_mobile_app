import 'package:flutter/material.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/no_result_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Container(
        child: NoResult(context, message: 'Tidak ada notifikasi'),
      ),
    );
  }
}
