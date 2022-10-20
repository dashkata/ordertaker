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
        .child('Images/Restaurants/$parsedRestaurant/$parsedRestaurant.jpg');
    try {
      return await storageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> uploadItemImage({
    required File photoFile,
    required String restaurantName,
    required String itemName,
  }) async {
    final parsedRestaurant = restaurantName.replaceAll(' ', '');
    final storageRef = FirebaseStorage.instance.ref();
    final menuRef =
        storageRef.child('Images/Restaurants/$parsedRestaurant/Menu/$itemName');
    try {
      await menuRef.putFile(photoFile);
      return await menuRef.getDownloadURL();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadRestaurantImage({
    required File photoFile,
    required int index,
    required String restaurantName,
  }) async {
    final parsedRestaurant = restaurantName.replaceAll(' ', '');
    final storageRef = FirebaseStorage.instance.ref();
    final restaurantRef = storageRef.child(
      'Images/Restaurants/$parsedRestaurant/Photos/$parsedRestaurant $index',
    );
    try {
      await restaurantRef.putFile(photoFile);
      return await restaurantRef.getDownloadURL();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}
