import 'package:flutter/cupertino.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';

class UserProvider with ChangeNotifier {
//  UserModel user;
  String idUser;
  MainSharedPreferences mainSharedPreferences = MainSharedPreferences();
  setUser() async {
    this.idUser = await mainSharedPreferences.getIdUser();
    notifyListeners();
  }
}
