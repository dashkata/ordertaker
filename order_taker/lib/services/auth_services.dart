import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Login succesful";
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case "wrong-password":
          errorMessage = "The password you entered is wrong, please try again.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Too many requests. Try again later.";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Register succesful";
    } on FirebaseAuthException catch (e) {
      return e.message as String;
    }
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
