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
