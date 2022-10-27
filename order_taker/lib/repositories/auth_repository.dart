import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firestore_repository.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw 'The password you entered is wrong, please try again.';
        case 'user-not-found':
          throw "User with this email doesn't exist.";
        case 'user-disabled':
          throw 'User with this email has been disabled.';
        case 'operation-not-allowed':
          throw 'Too many requests. Try again later.';
        default:
          throw 'An undefined Error happened.';
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
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          throw 'There is already a registration made with this email.';
          break;
        case 'invalid-email':
          throw 'The email you have entered is not valid.';
          break;
        case 'weak-password':
          throw 'The password you have entered is too weak, it must be at least 6 characters.';
          break;

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
      final FirestoreRepository tempRepo = FirestoreRepository();
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

  Future<String> updateProfilePic({required String photoURL}) async {
    await _firebaseAuth.currentUser?.updatePhotoURL(photoURL);

    return 'Picture chaned succesfully';
  }

  Future<void> updateUserName({
    required String name,
  }) async {
    await _firebaseAuth.currentUser?.updateDisplayName(name);
  }

  Future<String> updatePassword({required String passowrd}) async {
    await _firebaseAuth.currentUser?.updatePassword(passowrd);
    return 'Password changed Succsefully';
  }

  Future<String> updateEmail({required String email}) async {
    await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);
    return 'Email changed succesfully to: $email, please verify the new email address.';
  }

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
