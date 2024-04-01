import 'package:aikon/model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferController extends GetxController {
  var loading = false.obs;

  List<OfferModel> allOffers = [];

  var isSell = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  var imagesList = [];
  var channelList = [];
  var postAnonymously = false.obs;
}
