import 'package:aikon/constants/constants.dart';
import 'package:flutter/material.dart';

showSnackBar(String message,
    {bool showAction = false, Function? handleChange}) {
  return ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
      action: showAction
          ? SnackBarAction(
              label: 'Undo',
              onPressed: () {
                if (handleChange != null) {
                  handleChange();
                }
              },
            )
          : null,
    ),
  );
}
