import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class CustomButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.imagePath,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(CustomColors.secondaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // fixedSize: MaterialStateProperty.all(
        //   const Size(90, 80),
        // ),
      ),
      child: Column(
        children: [
          Container(
            width: 35,
            padding: const EdgeInsets.only(top: 9),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 0),
          // Adjust the spacing between the image and text as needed
          Text(
            buttonText,
            style: const TextStyle(
              color: CustomColors.thirdColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
