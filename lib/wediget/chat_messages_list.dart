import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../assets/custom_colors/colors.dart';

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
    required this.isIconVisible,
    required this.seenIcon,
    required this.messageType,
  });

  String message;
  int timeStamp;
  Color backColor;
  Color textColor;
  double RBL;
  double RBR;
  EdgeInsets Margin;
  Alignment inSideContaintAlign;
  bool isIconVisible;
  Icon seenIcon;
  String messageType;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Convert timestamp to a DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    // Format the DateTime object to a string
    String formattedTime = DateFormat('h:mma MMM,d').format(dateTime);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: inSideContaintAlign,
                      child: messageType == 'Text'
                          ? Text(
                              message,
                              style: TextStyle(color: textColor),
                            )
                          : SizedBox(
                              width: 200,
                              child: CachedNetworkImage(
                                imageUrl: message,
                                // Replace the URL above with the actual URL of your image
                                placeholder: (context, url) => SpinKitThreeBounce(
                                  color: CustomColors.thirdColor,
                                  size: size.width / 8,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                    ),
                    const SizedBox(height: 3),
                    Align(
                      alignment: inSideContaintAlign,
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          Text(
                            formattedTime,
                            style: TextStyle(color: textColor),
                          ),
                          const SizedBox(width: 2),
                          Visibility(
                            visible: isIconVisible,
                            child: seenIcon,
                          ),
                        ],
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
