import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate({@required DateTime date}) {
    final DateFormat _formatter = DateFormat('yMMMMEEEEd');
    return _formatter.format(date);
  }

  String dMy({@required DateTime date}) {
    final DateFormat _formatter = DateFormat('d MMMM y');
    return _formatter.format(date);
  }

  String hhmm({@required DateTime date}) {
    final DateFormat _formatter = DateFormat('hh:mm a');
    return _formatter.format(date);
  }
}
