import 'package:aikon/model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OfferController extends GetxController {
  var loadingMyOffers = false.obs;
  var loadingOtherOffers = false.obs;

  List<OfferModel> myOffersListings = [];
  List<OfferModel> otherOffersListings = [];

  var isSell = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  var selectedImageList = <XFile>[].obs;
  var selectedImageUrlList = <String>[].obs;
  List<String> channelList = [];
  var postAnonymously = false.obs;

  List<String> newUpdatedselectedImageUrlList = [];

  void clearAllFields() {
    isSell.value = false;
    titleController.clear();
    subTitleController.clear();
    descriptionController.clear();
    countryNameController.clear();
    cityNameController.clear();
    selectedImageList.clear();
    selectedImageUrlList.clear();
    channelList.clear();
    postAnonymously.value = false;
  }
}
