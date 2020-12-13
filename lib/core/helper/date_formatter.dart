import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate({@required DateTime date}) {
    final DateFormat _formatter = DateFormat('yMMMMEEEEd');
    return _formatter.format(date);
  }
}
