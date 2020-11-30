import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimeal/core/models/user_model.dart';
import 'package:gimeal/core/extensions/firebase_user_extension.dart';
import 'package:gimeal/core/services/firebase_firestore/FireUserService.dart';

class AuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password, String nama, String noHp) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = result.user.convertToUser(nama: nama, hp: noHp, createdAt: DateTime.now().toIso8601String());

      await UserServices.updateUser(userModel);
      
      return SignInSignUpResult(user: userModel);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }
}

class SignInSignUpResult {
  final UserModel user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
