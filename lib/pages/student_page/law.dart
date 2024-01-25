import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class Law extends StatelessWidget {
  const Law({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(
        child: Text(
          'Law',
          style: TextStyle(
            color: CustomColors.thirdColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
