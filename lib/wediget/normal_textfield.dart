import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String? hintText;
  final String? lableText;
  final bool obscureText;
  final Icon? prifixIcon;
  final IconButton? surfixIcon;
  final TextInputType? keybordType;
  final FormFieldValidator? validator;

  const MyTextField({
    super.key,
    this.controller,
    this.hintText,
    required this.obscureText,
    this.lableText,
    this.prifixIcon,
    this.surfixIcon,
    this.keybordType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: CustomColors.thirdColor,
      ),
      keyboardType: keybordType,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: lableText,
        labelStyle: const TextStyle(
          color: CustomColors.fourthColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: CustomColors.fourthColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: CustomColors.thirdColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: CustomColors.primaryColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: CustomColors.fourthColor,
        ),
        prefixIcon: prifixIcon,
        suffixIcon: surfixIcon,
      ),
    );
  }
}
