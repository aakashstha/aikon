import 'dart:io';

import 'package:aikon/constants/colors.dart';
import 'package:aikon/controller/auth_controller.dart';
import 'package:aikon/firebase/offer_service.dart';
import 'package:aikon/firebase/upload_service.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/screens/widgets/text_field.dart';
import 'package:aikon/utilities/pick_images.dart';
import 'package:aikon/utilities/validator.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Add and Update Offer
class AddOffer extends StatefulWidget {
  AddOffer({super.key});

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final _formKey = GlobalKey<FormState>();
  final OfferController _offerController = Get.put(OfferController());
  final AuthController _authController = Get.put(AuthController());
  List<DropDownValueModel> dropDownList = [
    // DropDownValueModel(name: 'name1', value: "1"),
  ];

  @override
  void initState() {
    initialize();

    super.initState();
  }

  void initialize() {
    if (dropDownList.isEmpty) {
      for (var i = 0; i < _authController.allChannelList.length; i++) {
        var channelId = _authController.allChannelList[i].id;
        var channelName = _authController.allChannelList[i].title;

        dropDownList
            .add(DropDownValueModel(name: channelName, value: channelId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.blueYonder,
        title: const Text(
          "Add Offer",
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            _offerController.clearAllFields();
            Get.back();
            Get.back();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(
            () => ListView(
              children: [
                const SizedBox(height: 30),

                // InkWell(
                //   onTap: () {
                //     print(_offerController.myOffersListings[1].imagesList);
                //   },
                //   child: const Text(
                //     "Press Me",
                //     style: TextStyle(fontSize: 40),
                //   ),
                // ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Post an offer",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.channelSubtitle,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Buying or Selling
                Row(
                  children: [
                    Text(
                      "Buying",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.wantToBuy,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FlutterSwitch(
                        height: 30.0,
                        width: 60.0,
                        toggleSize: 15.0,
                        inactiveSwitchBorder: Border.all(
                          color: AppColors.wantToBuy,
                          width: 3.0,
                        ),
                        inactiveColor: AppColors.white,
                        inactiveToggleColor: AppColors.wantToBuy,
                        activeSwitchBorder: Border.all(
                          color: AppColors.wantToSell,
                          width: 3.0,
                        ),
                        activeColor: AppColors.white,
                        activeToggleColor: AppColors.wantToSell,
                        value: _offerController.isSell.value,
                        onToggle: (value) {
                          setState(() {
                            _offerController.isSell.value = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Selling",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.wantToSell,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: AppColors.searchBackground,
                  thickness: 1,
                ),
                const SizedBox(height: 15),

                // title, subtitle, description
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.searchBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      customTextField(
                        hintText: "Title",
                        controller: _offerController.titleController,
                        validate: (val) {
                          return Validator.validateEmpty(val!, "Title");
                        },
                      ),
                      customTextField(
                        hintText: "Subtitle",
                        controller: _offerController.subTitleController,
                        validate: (val) {
                          return Validator.validateEmpty(val!, "Subtitle");
                        },
                      ),
                      customTextField(
                        hintText: "Description....",
                        controller: _offerController.descriptionController,
                        maxLine: 5,
                        validate: (val) {
                          return Validator.validateEmpty(val!, "Description");
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Country and City
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 7, left: 10, right: 10, bottom: 7),
                        decoration: BoxDecoration(
                          color: AppColors.searchBackground,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: customTextField(
                            hintText: "Country",
                            isReadOnly: true,
                            controller: _offerController.countryController,
                            textFieldTopHeight: 0,
                            validate: (val) {
                              return Validator.validateEmpty(val!, "Country");
                            },
                            onTap: () {
                              showCountryPicker(
                                useRootNavigator: true,
                                useSafeArea: true,
                                context: context,
                                showPhoneCode: false,
                                onSelect: (Country country) {
                                  _offerController.countryController.text =
                                      country.name;
                                },
                              );
                            }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 7, left: 10, right: 10, bottom: 7),
                        decoration: BoxDecoration(
                          color: AppColors.searchBackground,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: customTextField(
                          hintText: "City",
                          controller: _offerController.cityController,
                          textFieldTopHeight: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Upload Images from Gallery
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ...List.generate(
                      _offerController.selectedImageList.length,
                      (index) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(
                                    File(_offerController
                                        .selectedImageList[index]["file"].path),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      _offerController.selectedImageList
                                          .removeAt(index);
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),

                            // Private or Public Button
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Private",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.channelSubtitle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FlutterSwitch(
                                  height: 25.0,
                                  width: 42.0,
                                  toggleSize: 10.0,
                                  inactiveSwitchBorder: Border.all(
                                    color: AppColors.subtitleGrey,
                                    width: 4.0,
                                  ),
                                  inactiveColor: AppColors.white,
                                  inactiveToggleColor: AppColors.subtitleGrey,
                                  activeSwitchBorder: Border.all(
                                    color: AppColors.blueYonder,
                                    width: 4.0,
                                  ),
                                  activeColor: AppColors.white,
                                  activeToggleColor: AppColors.blueYonder,
                                  value: _offerController
                                      .selectedImageList[index]["isPrivate"],
                                  onToggle: (value) {
                                    setState(() {
                                      _offerController.selectedImageList[index]
                                          ["isPrivate"] = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        await pickSelectedImage();
                        print(_offerController.selectedImageList);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 34, vertical: 34),
                        decoration: BoxDecoration(
                          color: AppColors.searchBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.upload),
                            Text("Upload"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Select Channel
                SizedBox(
                  height: 38,
                  child: DropDownTextField.multiSelection(
                    validator: (val) {
                      return Validator.validateEmpty(val!, "Channel");
                    },
                    textFieldDecoration: InputDecoration(
                      hintText: "Select Channel ",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: const BorderSide(
                          color: AppColors.searchBackground,
                        ),
                      ),
                    ),
                    // displayCompleteItem: true,
                    submitButtonColor: AppColors.blueYonder,
                    submitButtonText: "Done",
                    submitButtonTextStyle: const TextStyle(
                      color: AppColors.white,
                    ),
                    dropDownList: dropDownList,
                    onChanged: (val) {
                      _offerController.channelList.clear();
                      _offerController.channelsId.clear();

                      for (int i = 0; i < val.length; i++) {
                        _offerController.channelList
                            .add({"id": val[i].value, "title": val[i].name});

                        _offerController.channelsId.add(val[i].value);
                      }

                      _formKey.currentState!.validate();
                    },
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.blueYonder,
                      checkColor: AppColors.white,
                      value: _offerController.postAnonymously.value,
                      onChanged: (value) {
                        setState(() {
                          _offerController.postAnonymously.value = value!;
                        });
                      },
                    ),
                    Text(
                      "Post Anonymously",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Post/Update Button
                TextButton(
                  onPressed: () async {
                    print(_offerController.channelList);
                    if (_formKey.currentState!.validate()) {
                      _offerController.loadingOtherOffers.value = true;
                      Get.back();
                      await FirebaseUploadService
                          .uploadImagesToFirebaseStorage();
                      await FirebaseOfferService.createOffer();
                      _offerController.loadingOtherOffers.value = false;
                      _offerController.clearAllFields();
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.blueYonder,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child:
                        // Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           const Text("Changing..."),
                        //           const SizedBox(width: 20),
                        //           circularIndicator()
                        //         ],
                        //       )
                        const Text("Post Offer"),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
