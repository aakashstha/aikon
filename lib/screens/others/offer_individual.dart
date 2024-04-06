import 'package:aikon/constants/colors.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferIndividual extends StatefulWidget {
  final OfferModel offer;
  const OfferIndividual({super.key, required this.offer});

  @override
  State<OfferIndividual> createState() => _OfferIndividualState();
}

class _OfferIndividualState extends State<OfferIndividual> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  late OfferModel offer;

  @override
  void initState() {
    offer = widget.offer;

    titleController.text = offer.title;
    subTitleController.text = offer.subtitle;
    descriptionController.text = offer.description;
    countryNameController.text = offer.countryName;
    cityNameController.text = offer.cityName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.blueYonder,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 30),

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
                    value: offer.isSell,
                    onToggle: (value) {},
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
                    isReadOnly: true,
                    hintText: "Title",
                    controller: titleController,
                  ),
                  customTextField(
                    isReadOnly: true,
                    hintText: "Subtitle",
                    controller: subTitleController,
                  ),
                  customTextField(
                    isReadOnly: true,
                    hintText: "Description....",
                    controller: descriptionController,
                    maxLine: 5,
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
                        controller: countryNameController,
                        textFieldTopHeight: 0,
                        onTap: () {}),
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
                      isReadOnly: true,
                      hintText: "City",
                      controller: cityNameController,
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
                  offer.imagesList.length,
                  (index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                offer.imagesList[index]["url"],
                                fit: BoxFit.fill,
                              ),
                            ),
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
                              value: offer.imagesList[index]["isPrivate"],
                              onToggle: (value) {},
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Selected Channel
            Text(
              "Selected Channel",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...List.generate(
                  offer.channelList.length,
                  (index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.searchBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            offer.channelList[index],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.blueYonder,
                  checkColor: AppColors.white,
                  value: offer.isAnonymous,
                  onChanged: (value) {},
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
