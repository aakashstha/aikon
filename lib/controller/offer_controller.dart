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
  var selectedImageList1 = <Map<String, dynamic>>[].obs;

  var selectedImageUrlList = [].obs;
  List<dynamic> channelList = [];
  var postAnonymously = false.obs;

  // used in Update
  List deleteUnSelectedImageUrlList = [];

  void clearAllFields() {
    isSell.value = false;
    titleController.clear();
    subTitleController.clear();
    descriptionController.clear();
    countryNameController.clear();
    cityNameController.clear();
    selectedImageList.clear();
    selectedImageUrlList.clear();
    selectedImageList1.clear();
    channelList.clear();
    postAnonymously.value = false;
    deleteUnSelectedImageUrlList.clear();
  }
}
