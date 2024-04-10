import 'dart:io';

import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final OfferController _offerController = Get.put(OfferController());
final AuthController _authController = Get.put(AuthController());

//  Step 1. Pick/Capture an image
//  Step 2. Upload the image to Firebase storage
//  Step 3. Get the URL of the uploaded image
//  Step 4. Store the image URL inside the corresponding document of the database.
//  Step 5. Display the image on the list view.

Future<void> pickSelectedImage() async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile> pickedImages = await imagePicker.pickMultiImage();

    _offerController.selectedImageList.clear();
    for (var element in pickedImages) {
      _offerController.selectedImageList
          .add({"file": element, "isPrivate": false});
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future<void> pickProfileImage() async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    _authController.profilePic.value = pickedImage!;
  } catch (e) {
    print("Error: $e");
  }
}
