import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({
    required this.message,
    required this.timeStamp,
    required this.backColor,
    required this.textColor,
    required this.RBL,
    required this.RBR,
    required this.inSideContaintAlign,
  });

  String message;
  DateTime timeStamp;
  Color backColor;
  Color textColor;
  double RBL;
  double RBR;
  Alignment inSideContaintAlign;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.5,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(RBL),
          bottomRight: Radius.circular(RBR),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: inSideContaintAlign,
            child: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          ),
          Align(
            alignment: inSideContaintAlign,
            child: Text(
              timeStamp.toString(),
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
