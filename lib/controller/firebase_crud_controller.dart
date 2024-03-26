import 'dart:ffi';

import 'package:aikon/model/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var locationDetailsLenght = 0.obs;

  String firebaseCollectionName = "offers";

  // Add Location Details
  Future<void> addOffer() async {
    var colletion = OfferModel(
      id: "1",
      userId: "1",
      title: "title",
      subtitle: "subtitle",
      isBuying: true,
      country: "country",
      city: "city",
      color: 1,
      pieces: "pieces",
      images: [],
      channel: "channel",
      isAnonymous: true,
      createdAt: DateTime.now(),
    );

    try {
      await _firebaseFirestore
          .collection(firebaseCollectionName)
          .add(colletion.toJson());
    } catch (e) {
      print("ERROR: + e.message");
    }
  }

//   // Get all Location Details
//   Future<void> getAllOffers() async {
//     await FirebaseFirestore.instance
//         .collection('locationDetails')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       _mapController.allLocationDetails.clear();

//       for (var doc in querySnapshot.docs) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         data['id'] = doc.id;

//         // convert 24 format time to 12 format
//         data["openingTime"] = data["openingTime"].isEmpty
//             ? ""
//             : convert24To12(data["openingTime"]);
//         data["closingTime"] = data["closingTime"].isEmpty
//             ? ""
//             : convert24To12(data["closingTime"]);

//         _mapController.allLocationDetails
//             .add(AddLocationDetailsModel.fromJson(data));
//       }
//     });
//   }

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
