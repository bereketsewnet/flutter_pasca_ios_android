import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({
    required this.message,
    required this.timeStamp,
    required this.backColor,
    required this.textColor,
    required this.RBL,
    required this.RBR,
    required this.inSideContaintAlign,
    required this.Margin,
  });

  String message;
  int timeStamp;
  Color backColor;
  Color textColor;
  double RBL;
  double RBR;
  EdgeInsets Margin;
  Alignment inSideContaintAlign;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Convert timestamp to a DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    // Format the DateTime object to a string
    String formattedTime = DateFormat('h:mm a MMM,d').format(dateTime);
    // DateFormat('E,MMM d h:mma')
    return Row(
        mainAxisAlignment: inSideContaintAlign == Alignment.centerLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Flexible(
            child: IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 5,
                  top: 5,
                  bottom: 5,
                ),
                margin: Margin,
                decoration: BoxDecoration(
                  color: backColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
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
                    const SizedBox(height: 3),
                    Align(
                      alignment: inSideContaintAlign,
                      child: Text(
                        formattedTime,
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
