import 'dart:ffi';
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
    _offerController.selectedImageList.value =
        await imagePicker.pickMultiImage();
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
        // IMG20240404214427.jpg from this taking only extension
        String imageName = _offerController.selectedImageList[i].name;
        List<String> parts = imageName.split(".");
        String imageExtension = parts[1];

        // Get a reference to storage root
        Reference referenceRoot = FirebaseStorage.instance.ref();
        // Create a reference for the image to be stored
        // time stamp will be same so added incrementer at the end of image name
        Reference imageUploadReference =
            referenceRoot.child("images/$timestamp$i.$imageExtension");

        await imageUploadReference
            .putFile(File(_offerController.selectedImageList[i].path));

        // Get the download URL of the image
        var url = await imageUploadReference.getDownloadURL();
        _offerController.selectedImageUrlList.add(url);
        print("Image Uploaded and URL got set");
      }
      _offerController.loadingOtherOffers.value = false;
    }
  } catch (e) {
    _offerController.loadingOtherOffers.value = false;
    print("Error: $e");
  }
}

Future<void> deleteImageFromFirebaseStorage(OfferModel offer) async {
  _offerController.loadingMyOffers.value = true;

  try {
    for (var i = 0; i < offer.imagesList.length; i++) {
      // To get the image name from URL
      String url = offer.imagesList[i];
      Uri uri = Uri.parse(url);
      String imageName = uri.pathSegments.last;

      // Get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      // Create a reference for the image to be stored
      // time stamp will be same so added incrementer at the end of image name
      Reference imageDeleteReference = referenceRoot.child(imageName);

      await imageDeleteReference.delete();
    }
    _offerController.loadingMyOffers.value = false;
  } catch (e) {
    _offerController.loadingMyOffers.value = false;
    print("Error: $e");
  }
}
