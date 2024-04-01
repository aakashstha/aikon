import 'package:aikon/controller/offer_controller.dart';
import 'package:aikon/model/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final OfferController _offerController = Get.put(OfferController());

class FirebaseCRUDService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  var locationDetailsLenght = 0.obs;

  static String offerCollection = "offers";

  // Add Offer
  static Future<void> createOffer() async {
    var offer = OfferModel(
      isSell: _offerController.isSell.value,
      title: _offerController.titleController.text,
      subtitle: _offerController.subTitleController.text,
      description: _offerController.descriptionController.text,
      countryName: _offerController.countryNameController.text,
      cityName: _offerController.cityNameController.text,
      imagesList: _offerController.imagesList,
      channelList: _offerController.channelList,
      isAnonymous: _offerController.postAnonymously.value,
      createdAt: DateTime.now(),
    );

    try {
      await _firebaseFirestore.collection(offerCollection).add(offer.toJson());
    } catch (e) {
      print("ERROR: + e.message");
    }
  }

  // Get all Offers Details
  static Future<void> getAllOffers() async {
    _offerController.allOffers.clear();

    await _firebaseFirestore
        .collection(offerCollection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;

        _offerController.allOffers.add(OfferModel.fromJson(data));
      }

      print(_offerController.allOffers);
    });
  }

// // Update Location Details
//   Future<void> updateLocationDetails(String id) async {
//     String openingTime24Hour = _addController.openingTimeController.text.isEmpty
//         ? ""
//         : convert12To24(_addController.openingTimeController.text);
//     String closingTime24Hour = _addController.closingTimeController.text.isEmpty
//         ? ""
//         : convert12To24(_addController.closingTimeController.text);

//     var a = AddLocationDetailsModel(
//       latlng: GeoPoint(
//         _mapController.individualLocationDetails.value.latlng.latitude,
//         _mapController.individualLocationDetails.value.latlng.longitude,
//       ),
//       placeName: _addController.placeNameController.text,
//       vehicle: _addController.vehicle,
//       charge: _addController.charge.value,
//       locationType: _addController.locationType.value,
//       openingDays: _addController.openingDays,
//       isAllDayOpen: _addController.isAllDayOpen.value,
//       openingTime: openingTime24Hour,
//       closingTime: closingTime24Hour,
//     );

//     try {
//       await _firebaseFirestore
//           .collection('locationDetails')
//           .doc(id)
//           .update(a.toJson());
//     } catch (e) {
//       print("ERROR: + e.message");
//     }
//   }

//   // Delete Location Details
//   Future<void> deleteLocationDetails(String id) async {
//     await _firebaseFirestore.collection('locationDetails').doc(id).delete();
//   }
}
