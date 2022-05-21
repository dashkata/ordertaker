import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

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
        email: email,
        password: password,
      );
      return "Register succesful";
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case "email-already-in-use":
          errorMessage =
              "There is already a registration made with this email.";
          break;
        case "invalid-email":
          errorMessage = "The email you have entered is not valid.";
          break;
        case "weak-password":
          errorMessage =
              "The password you have entered is too weak, it must be at least 6 characters.";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }

  Future<String> updateUserName({
    required String name,
  }) async {
    await _firebaseAuth.currentUser?.updateDisplayName(name);
    return "Name changed succesfully";
  }

  Future<String> updatePassword({required String passowrd}) async {
    await _firebaseAuth.currentUser?.updatePassword(passowrd);
    return "Password changed Succsefully";
  }

  Future<String> updateEmail({required String email}) async {
    await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);
    return "Email changed succesfully to: $email, please verify the new email address.";
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
