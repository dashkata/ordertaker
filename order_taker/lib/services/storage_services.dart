import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  Future<String?> uploadProfilePic(
      {required File photoFile, required String email}) async {
    final storageRef = FirebaseStorage.instance.ref("Images");
    final imagesRef = storageRef.child(email);

    try {
      imagesRef.putFile(photoFile);
      return "Picture changed succesfully";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> fetchProfilePic({required String email}) async {
    final storageRef = FirebaseStorage.instance.ref("Images").child(email);
    try {
      return await storageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
