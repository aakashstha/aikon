import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:aikon/constants/constants.dart';
import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/firebase/offer_service.dart';
import 'package:aikon/firebase/upload_service.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:aikon/screens/others/update_offer.dart';
import 'package:aikon/screens/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final OfferController _offerController = Get.put(OfferController());

Future<void> showOfferBottomSheet(
    {required int index, required OfferModel offer}) {
  return showAdaptiveActionSheet(
    context: navKey.currentContext!,
    actions: <BottomSheetAction>[
      // BottomSheetAction(
      //   title: const Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(Icons.remove_red_eye),
      //       SizedBox(width: 5),
      //       Text('View'),
      //     ],
      //   ),
      //   onPressed: (context) {},
      // ),
      BottomSheetAction(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit),
            SizedBox(width: 5),
            Text('Edit'),
          ],
        ),
        onPressed: (context) async {
          // update offer
          Get.to(
            () => UpdateOffer(index: index, offer: offer),
          );
        },
      ),
      BottomSheetAction(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete),
            SizedBox(width: 5),
            Text('Delete'),
          ],
        ),
        onPressed: (context) async {
          print("object");
          deleteAlertDialog(
            offerId: offer.id,
            title: "Are you sure you want to delete this offer?",
            subTitle: "",
            okButton: () async {
              Get.back();
              Get.back();

              _offerController.loadingMyOffers.value = true;
              await FirebaseUploadService.deleteImageFromFirebaseStorage(
                  offer.images);
              await FirebaseOfferService.deleteOffer(offer.id);
              await FirebaseOfferService.getAllMyOffers();
              _offerController.loadingMyOffers.value = false;
            },
            secondButtonTitle: "Cancel",
            secondButton: () {
              Get.back();
              Get.back();
            },
          );
        },
      ),
    ],
    cancelAction: CancelAction(
      title: const Text('Cancel'),
    ),
  );
}
