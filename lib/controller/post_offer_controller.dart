import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostOfferController extends GetxController {
  var loading = false.obs;

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
