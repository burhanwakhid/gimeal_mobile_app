import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimeal/core/models/user_model.dart';
import 'package:gimeal/core/extensions/firebase_user_extension.dart';
import 'package:gimeal/core/services/firebase_firestore/FireUserService.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';

class AuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password, String nama, String noHp) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = result.user.convertToUser(
          nama: nama,
          hp: noHp,
          fotoUser: 'F51f6fb256629fc755b8870c801092942',
          createdAt: DateTime.now().toIso8601String());

      await MainSharedPreferences().setIdUser(userModel.id);
      await MainSharedPreferences().setHpUser(userModel.noHp);
      await MainSharedPreferences().setUserName(userModel.nama);
      await MainSharedPreferences().setUserFoto(userModel.fotoUser);
      await MainSharedPreferences().setEmailUser(userModel.email);

      await UserServices.updateUser(userModel);

      return SignInSignUpResult(user: userModel);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel userModel = await result.user.fromFireStore();

      return SignInSignUpResult(user: userModel);
    } catch (e) {
      // return SignInSignUpResult(message: e);
      throw e.toString();
    }
  }
}

class SignInSignUpResult {
  final UserModel user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
