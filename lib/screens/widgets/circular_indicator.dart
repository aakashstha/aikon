import 'package:aikon/constants/colors.dart';
import 'package:flutter/material.dart';

Widget circularButtonIndicator() {
  return const SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      strokeWidth: 3,
      color: AppColors.white,
    ),
  );
}

Widget circularCenterScreenIndicator() {
  return const SizedBox(
    height: 50,
    width: 50,
    child: CircularProgressIndicator(
      strokeWidth: 3,
      color: AppColors.blueYonder,
    ),
  );
}
