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
  String timeStamp;
  Color backColor;
  Color textColor;
  double RBL;
  double RBR;
  Alignment inSideContaintAlign;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
        mainAxisAlignment: inSideContaintAlign == Alignment.centerLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Flexible(
            child: IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
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
                    SizedBox(height: 3),
                    Align(
                      alignment: inSideContaintAlign,
                      child: Text(
                        timeStamp,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
