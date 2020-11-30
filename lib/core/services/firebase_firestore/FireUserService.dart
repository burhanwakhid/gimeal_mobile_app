import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimeal/core/models/user_model.dart';

class UserServices {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserModel userModel) async {
    _collectionReference.doc(userModel.id).set({
      'email': userModel.email,
      'hp': userModel.noHp,
      'nama': userModel.nama,
      'createdAt': userModel.createdAt
    });
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _collectionReference.doc(id).get();

    return UserModel(
      id,
      snapshot.data()['email'],
      nama: snapshot.data()['nama'],
      noHp: snapshot.data()['hp'],
      createdAt: snapshot.data()['createdAt'].toString(),
    );
  }
}
