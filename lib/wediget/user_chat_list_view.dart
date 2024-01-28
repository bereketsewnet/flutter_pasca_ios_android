import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

import '../pages/student_page/chat_room.dart';

Widget buildChatCard(Map<String, dynamic> users) {
  // Customize the appearance of your chat card
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
      color: CustomColors.secondaryColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            users['profilePic'] ??
                'https://www.catholicsingles.com/wp-content/uploads/2020/06/blog-header-3.png',
          ),
          backgroundColor: CustomColors.secondaryColor,
          radius: 30,
        ),
        title: Text(
          users['name'] ?? 'FullName',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: CustomColors.thirdColor),
        ),
        subtitle: Row(
          children: [
            const SizedBox(width: 3),
            Text(
              users['message'],
              style: const TextStyle(
                color: CustomColors.fourthColor,
              ),
            ),
          ],
        ),
        trailing: Text(
          users['timeStamp'] ?? 'Grade',
          style: const TextStyle(color: CustomColors.fourthColor),
        ),
      ),
    ),
  );
}
