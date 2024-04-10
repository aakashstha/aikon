import 'dart:io';

import 'package:aikon/controller/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final AuthController _authController = Get.put(AuthController());

class FirebaseUploadService {
  static Future<void> uploadProfileImage() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      XFile imgFile = _authController.profilePic.value;
      // IMG20240404214427.jpg from this taking only extension
      String imageName = imgFile.name;
      List<String> parts = imageName.split(".");
      String imageExtension = parts[1];

      // Get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      // Create a reference for the image to be stored
      // time stamp will be same so added incrementer at the end of image name
      Reference imageUploadReference =
          referenceRoot.child("users/$timestamp.$imageExtension");

      await imageUploadReference.putFile(File(imgFile.path));

      // Get the download URL of the image
      var url = await imageUploadReference.getDownloadURL();

      _authController.urlProfilePic = url;
      print("Profile Picture Uploaded and URL got set");
    } catch (e) {
      print("Error: $e");
    }
  }
}
