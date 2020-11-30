import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gimeal/core/models/user_model.dart';

extension FirebaseUserExtension on auth.User {
  UserModel convertToUser(
          {
            String nama = "no name",
            String hp = "098342"
          }) =>
      UserModel(this.uid, this.email, nama: nama, noHp: hp);

  // Future<UserModel> fromFireStore() async => await UserServices.getUser(this.uid);
}
