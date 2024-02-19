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
    String formattedTime = DateFormat('h:mm a').format(dateTime); // h:mm a d/M/yy/
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.secondaryColor,
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
        child: Column(
          children: [
            ListTile(
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
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: CustomColors.thirdColor),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if(chatingUsers['isSeen'] == true)
                       const Icon(
                          Icons.done_all_rounded,
                          color: CustomColors.colorFour,
                          size: 18,
                        )
                      else
                       const Icon(
                          Icons.done_rounded,
                          color: CustomColors.colorFour,
                          size: 18,
                        ),


                      if (chatingUsers['messageType'] == 'Text')
                        Expanded(
                          child: Text(
                            chatingUsers['message'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: CustomColors.colorFive,
                            ),
                          ),
                        )
                      else
                        const Text(
                          'Image',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: CustomColors.colorFour,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formattedTime,
                    style: const TextStyle(color: CustomColors.colorFive),
                  ),
                  const SizedBox(height: 8),
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: CustomColors.colorFour,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: CustomColors.thirdColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Divider(
                color: CustomColors.primaryColor,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
