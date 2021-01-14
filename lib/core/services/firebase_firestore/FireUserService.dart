import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimeal/core/models/user_model.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';

class UserServices {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserModel userModel) async {
    _collectionReference.doc(userModel.id).set({
      'email': userModel.email,
      'hp': userModel.noHp,
      'nama': userModel.nama,
      'foto_user': userModel.fotoUser,
      'createdAt': Timestamp.now()
    });
  }

  static Future<bool> editUser(
      String idUser, String hp, String nama, String fotoUser) async {
    try {
      _collectionReference.doc(idUser).update({
//        'email': email,
        'hp': hp,
        'nama': nama,
        'foto_user': 'F$fotoUser',
      });
      await MainSharedPreferences().setHpUser(hp);
      await MainSharedPreferences().setUserName(nama);
      await MainSharedPreferences().setUserFoto('F$fotoUser');
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _collectionReference.doc(id).get();
    print(snapshot.data().toString());
    return UserModel(
      id,
      snapshot.data()['email'],
      nama: snapshot.data()['nama'],
      noHp: snapshot.data()['hp'],
      fotoUser: snapshot.data()['foto_user'],
      createdAt: snapshot.data()['createdAt'].toString(),
    );
  }
}
