import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gimeal/core/models/user_model.dart';
import 'package:gimeal/core/services/firebase_firestore/FireUserService.dart';

extension FirebaseUserExtension on auth.User {
  UserModel convertToUser({
    String nama = "no name",
    String hp = "098342",
    String createdAt = '',
    String fotoUser = 'F51f6fb256629fc755b8870c801092942',
  }) =>
      UserModel(
        this.uid,
        this.email,
        nama: nama,
        noHp: hp,
        fotoUser: fotoUser,
      );

  Future<UserModel> fromFireStore() async =>
      await UserServices.getUser(this.uid);
}
