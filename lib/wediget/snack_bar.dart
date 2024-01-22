import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: CustomColors.primaryColor,
        ),
      ),
      duration: const Duration(
        seconds: 2,
      ),
      backgroundColor: CustomColors.thirdColor,

      // Adjust the duration as needed
    ),
  );
}
