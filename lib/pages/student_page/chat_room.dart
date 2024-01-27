import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'package:pasca/wediget/chat_messages_list.dart';
import 'package:pasca/wediget/snack_bar.dart';

import '../../second_code_test.dart';

class ChatRoom extends StatefulWidget {
  String friendId;
  String profileImage;
  String friendName;

  ChatRoom({
    required this.friendId,
    required this.profileImage,
    required this.friendName,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _messageController = TextEditingController();
    final List<ChatMessage> chatMessages = [
      ChatMessage(
        text: 'Hello',
        sender: 'Me',
        timestamp: DateTime.now(),
      ),
      ChatMessage(
        text: 'Hi there!',
        sender: 'Friend',
        timestamp: DateTime.now().add(Duration(minutes: 5)),
      ),
      // Add more chat messages here
    ];
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        backgroundColor: CustomColors.secondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.thirdColor,
          ),
        ),
        title: Row(
          children: [
             CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.friendName,
              style: const TextStyle(
                color: CustomColors.thirdColor,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = chatMessages[index];
                  final isMe = message.sender == 'Me';

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: ChatMessageList(
                      // this is list item inside containt if it is me change border, alignment , and color based on bool answer
                      message: message.text,
                      timeStamp: message.timestamp,
                      RBL: isMe ? 20 : 3,
                      RBR: isMe ? 3 : 20,
                      backColor: isMe
                          ? CustomColors.secondaryColor
                          : CustomColors.fourthColor,
                      textColor: isMe
                          ? CustomColors.fourthColor
                          : CustomColors.primaryColor,
                      inSideContaintAlign:
                          isMe ? const Alignment(1, 0) : const Alignment(-1, 0),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: size.width / 1.4,
                  decoration: BoxDecoration(
                    color: CustomColors.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(
                      color: CustomColors.fourthColor,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo_camera_outlined,
                          color: CustomColors.thirdColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_voice_outlined,
                          color: CustomColors.thirdColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: sendMessage,
                    child: const CircleAvatar(
                      backgroundColor: CustomColors.thirdColor,
                      radius: 25,
                      child: Icon(
                        Icons.send_outlined,
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    String friendId = widget.friendId;
    String myId = await SharedPref().getUid() ?? uid;
    DatabaseReference dbRefChat =
        FirebaseDatabase.instance.ref().child('Chats');
    DatabaseReference dbRefChatList =
        FirebaseDatabase.instance.ref().child(myId).child(friendId);
    showSnackBar(context, myId);
    showSnackBar(context, friendId);
  }
}
