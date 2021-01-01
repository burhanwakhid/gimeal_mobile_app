import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class NavbarProvider with ChangeNotifier {
  int navIndex;

  setIndex({int index}) {
    navIndex = index;
    notifyListeners();
  }
}
