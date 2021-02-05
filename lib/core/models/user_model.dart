import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String nama;
  final String email;
  final String noHp;
  final String fotoUser;
  final Timestamp createdAt;

  UserModel(
    this.id,
    this.email, {
    this.nama,
    this.noHp,
    this.createdAt,
    this.fotoUser,
  });
}
