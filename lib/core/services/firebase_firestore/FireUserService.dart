import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimeal/core/models/user_model.dart';

class UserServices {
  static CollectionReference _collectionReference = FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserModel userModel) async {
    _collectionReference.doc(userModel.id).set({
      'email': userModel.email,
      'hp': userModel.noHp,
      'nama': userModel.nama
    });
  }
}