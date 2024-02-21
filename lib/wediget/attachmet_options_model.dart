import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class Attachment_options extends StatelessWidget {
  const Attachment_options({
    super.key,
    required this.description,
    required this.icon,
    this.onPressed,
  });

  final String description;
  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPressed,
          child: CircleAvatar(
            radius: 27,
            backgroundColor: CustomColors.colorFour,
            child: icon,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            color: CustomColors.thirdColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
