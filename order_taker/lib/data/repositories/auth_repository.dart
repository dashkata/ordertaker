import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../api/firestore_api.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Stream<User?> get authStateChange {
    print('object');
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw 'Wrong credentials, please try again!';
        case 'user-not-found':
          throw 'Wrong credentials, please try again!';
        case 'user-disabled':
          throw 'User with this email has been disabled.';
        case 'operation-not-allowed':
          throw 'Too many requests. Try again later.';
        default:
          throw 'An undefined error happened.';
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw 'There is already a registration made with this email.';
        case 'invalid-email':
          throw 'The email you have entered is not valid.';
        case 'weak-password':
          throw 'The password you have entered is too weak, it must be at least 6 characters.';

        default:
          throw 'An undefined Error happened.';
      }
    }
  }

  Future<String> adminSignUp({
    required String email,
    required String password,
    required String restaurantTitle,
  }) async {
    final FirebaseApp tempApp = await Firebase.initializeApp(
      name: 'temporaryRegister',
      options: Firebase.app().options,
    );
    try {
      final UserCredential result = await FirebaseAuth.instanceFor(app: tempApp)
          .createUserWithEmailAndPassword(email: email, password: password);
      final API tempRepo = API();
      await tempRepo.setUserType('Restaurant', result.user!.uid);
      await tempRepo.setRestaurantTitle(restaurantTitle, result.user!.uid);
      await FirebaseAuth.instanceFor(app: tempApp).signOut();
      await tempApp.delete();
      return 'Register successful, please verify your email address.';
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'There is already a registration made with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email you have entered is not valid.';
          break;
        case 'weak-password':
          errorMessage =
              'The password you have entered is too weak, it must be at least 6 characters.';
          break;

        default:
          errorMessage = 'An undefined Error happened.';
      }
      return errorMessage;
    }
  }

  Future<void> updateProfilePic({required String photoURL}) async =>
      await _firebaseAuth.currentUser?.updatePhotoURL(photoURL);

  Future<void> updateUserName({
    required String name,
  }) async =>
      await _firebaseAuth.currentUser?.updateDisplayName(name);

  Future<void> updatePassword({required String passowrd}) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(passowrd);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw 'The password you have entered is too weak, it must be at least 6 characters.';
      }
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Please enter a valid email address.';
      }
    }
  }

  Future<void> updateEmail({required String email}) async =>
      await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetLink(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
