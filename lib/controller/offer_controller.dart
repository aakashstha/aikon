import 'package:aikon/model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  var imagesList = [];
  var channelList = [];
  var postAnonymously = false.obs;

  void clearAllFields() {
    isSell.value = false;
    titleController.clear();
    subTitleController.clear();
    descriptionController.clear();
    countryNameController.clear();
    cityNameController.clear();
    imagesList.clear();
    channelList.clear();
    postAnonymously.value = false;
  }
}
