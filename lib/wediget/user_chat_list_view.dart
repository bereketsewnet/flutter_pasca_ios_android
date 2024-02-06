import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

import '../pages/student_page/chat_room.dart';

class StartchatUserList extends StatelessWidget {
  StartchatUserList(this.chatingUsers);

  Map<dynamic, dynamic> chatingUsers;

  @override
  Widget build(BuildContext context) {
    // Convert timestamp to a DateTime object
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(chatingUsers['timeStamp']);

    // Format the DateTime object to a string
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 25,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(
                  friendId: chatingUsers['friend'],
                  profileImage: chatingUsers['profilePic'],
                  friendName: chatingUsers['name']),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              chatingUsers['profilePic'] ?? '',
            ),
            backgroundColor: CustomColors.secondaryColor,
            radius: 30,
          ),
          title: Text(
            chatingUsers['name'] ?? 'FullName',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: CustomColors.thirdColor),
          ),
          subtitle: Row(
            children: [
              const SizedBox(width: 3),
              Text(
                chatingUsers['message'],
                style: const TextStyle(
                  color: CustomColors.thirdColor,
                ),
              ),
            ],
          ),
          trailing: Text(
            formattedTime,
            style: const TextStyle(color: CustomColors.thirdColor),
          ),
        ),
      ),
    );
  }
}
