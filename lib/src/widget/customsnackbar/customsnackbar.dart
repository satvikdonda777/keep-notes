import 'package:flutter/material.dart';
import 'package:provider_app/utilities/utilities.dart';

SnackBar MyCustomSnackbar(String title, Widget textbutton) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(bottom: 40, right: 8, left: 8),
      backgroundColor: VariableUtilities.theme.keeptextColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: FontUtilities.h16(
                    fontColor: VariableUtilities.theme.backgroundColor),
              ),
              const Spacer(),
              textbutton
            ],
          ),
        ],
      ));
}
