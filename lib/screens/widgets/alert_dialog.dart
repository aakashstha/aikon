import 'package:aikon/constants/colors.dart';
import 'package:aikon/constants/constants.dart';
import 'package:flutter/material.dart';

Future<void> deleteAlertDialog({
  String title = "",
  String subTitle = "",
  String okButonTitle = "OK",
  String secondButtonTitle = "",
  final void Function()? okButton,
  final void Function()? secondButton,
  required String offerId,
}) async {
  return showDialog<void>(
    context: navKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: subTitle == ""
            ? null
            : Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 112, 112, 112),
                ),
                textAlign: TextAlign.center,
              ),
        actions: <Widget>[
          Row(
            children: [
              // First Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueYonder,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: okButton,
                  child: Text(
                    okButonTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Second Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: secondButton,
                  child: Text(
                    secondButtonTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
