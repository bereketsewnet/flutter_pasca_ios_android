import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String btn_txt;
  final Color? back_btn;
  final double marginSize;
  final EdgeInsets? paddingSize;

  const MyButton({
    super.key,
    required this.onTap,
    required this.btn_txt,
    this.back_btn,
    required this.marginSize,
    this.paddingSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: paddingSize ?? EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: marginSize),
        decoration: BoxDecoration(
          color: back_btn,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            btn_txt,
            style: const TextStyle(
              color: CustomColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
