import 'dart:io';

import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final OfferController _offerController = Get.put(OfferController());

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

Future<void> uploadImagesToFirebaseStorage() async {
  _offerController.loadingOtherOffers.value = true;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  try {
    if (_offerController.selectedImageList.isNotEmpty) {
      for (var i = 0; i < _offerController.selectedImageList.length; i++) {
        XFile imgFile = _offerController.selectedImageList[i]["file"];
        // IMG20240404214427.jpg from this taking only extension
        String imageName = imgFile.name;
        List<String> parts = imageName.split(".");
        String imageExtension = parts[1];

        // Get a reference to storage root
        Reference referenceRoot = FirebaseStorage.instance.ref();
        // Create a reference for the image to be stored
        // time stamp will be same so added incrementer at the end of image name
        Reference imageUploadReference =
            referenceRoot.child("images/$timestamp$i.$imageExtension");

        await imageUploadReference.putFile(File(imgFile.path));

        // Get the download URL of the image
        var url = await imageUploadReference.getDownloadURL();
        _offerController.selectedImageUrlList.add({
          "url": url,
          "isPrivate": _offerController.selectedImageList[i]["isPrivate"]
        });
        print("Image Uploaded and URL got set");
      }
      _offerController.loadingOtherOffers.value = false;
    }
  } catch (e) {
    _offerController.loadingOtherOffers.value = false;
    print("Error: $e");
  }
}

Future<void> deleteImageFromFirebaseStorage(List imageURLList) async {
  _offerController.loadingMyOffers.value = true;

  try {
    for (var i = 0; i < imageURLList.length; i++) {
      // To get the image name from URL
      String url = imageURLList[i]["url"];
      Uri uri = Uri.parse(url);
      String imageName = uri.pathSegments.last;

      // Get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      // Create a reference for the image to be stored
      // time stamp will be same so added incrementer at the end of image name
      Reference imageDeleteReference = referenceRoot.child(imageName);

      await imageDeleteReference.delete();
      print("Image Deleted from Firebase Storage");
    }
    _offerController.loadingMyOffers.value = false;
  } catch (e) {
    _offerController.loadingMyOffers.value = false;
    print("Error: $e");
  }
}
