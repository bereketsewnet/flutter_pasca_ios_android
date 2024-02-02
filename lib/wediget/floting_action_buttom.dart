import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlotingButtom extends StatelessWidget {
  FlotingButtom({this.color, this.icon, this.onPressed,});

  Color? color;
  Icon? icon;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      child: icon,
    );
  }
}
