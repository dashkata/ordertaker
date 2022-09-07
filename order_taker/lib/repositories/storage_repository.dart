import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  Future<String> uploadProfilePic({
    required File photoFile,
    required String email,
  }) async {
    final storageRef = FirebaseStorage.instance.ref('Images/Users/');
    final imagesRef = storageRef.child(email);
    try {
      await imagesRef.putFile(photoFile);
      return 'Picture changed succesfully';
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  Future<String?> fetchProfilePic({required String email}) async {
    final storageRef = FirebaseStorage.instance.ref();
    final profilePicRef = storageRef.child('Images/Users/$email');
    try {
      return await profilePicRef.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String> fetchRestaurantPic({required String restaurantName}) async {
    final parsedRestaurant = restaurantName.replaceAll(' ', '');
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('Images/Restaurants/$parsedRestaurant.jpg');
    try {
      return await storageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }
}
