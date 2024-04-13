import 'package:aikon/model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferController extends GetxController {
  var loadingMyOffers = false.obs;
  var loadingOtherOffers = false.obs;
  var loadingFavouriteOffers = false.obs;

  var selectedChannelId = [].obs;
  var toggleStateIsSell = false.obs;

  List<OfferModel> myOffersListings = [];
  List<OfferModel> otherOffersListings = [];

  var isSell = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  var selectedImageList = <Map<String, dynamic>>[].obs;

  var selectedImageUrlList = [].obs;
  List<Map<String, dynamic>> channelList = [];
  var postAnonymously = false.obs;

  // used in Update
  List deleteUnSelectedImageUrlList = [];

  // favourite and archive
  var favouriteOfferList = [].obs;
  var archiveOfferList = [].obs;

  void clearAllFields() {
    isSell.value = false;
    titleController.clear();
    subTitleController.clear();
    descriptionController.clear();
    countryController.clear();
    cityController.clear();
    selectedImageList.clear();
    selectedImageUrlList.clear();
    selectedImageList.clear();
    channelList.clear();
    postAnonymously.value = false;
    deleteUnSelectedImageUrlList.clear();
  }
}
