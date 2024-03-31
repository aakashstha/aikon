import 'package:aikon/constants/colors.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  final String? Function(String?)? validate,
  int? maxLine = 1,
  TextCapitalization textCapitalization = TextCapitalization.none,
  double textFieldTopHeight = 15,
  double prefixWidth = 0,
  final void Function()? onTap,
  bool isReadOnly = false,
}) {
  return TextFormField(
    readOnly: isReadOnly,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validate,
    onTap: onTap,
    obscureText: obscureText,
    keyboardType: keyboardType,
    maxLines: maxLine,
    textCapitalization: textCapitalization,
    decoration: InputDecoration(
      border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      hintText: hintText,
      prefix: SizedBox(width: prefixWidth),
      filled: true,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(0, textFieldTopHeight, 10, 0),
      fillColor: AppColors.searchBackground,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.blueYonder),
      ),
    ),
  );
}
