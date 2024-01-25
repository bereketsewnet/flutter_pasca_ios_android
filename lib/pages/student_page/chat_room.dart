import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/chat_messages_list.dart';

import '../../second_code_test.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      ChatMessage(
        text:
            'wow the design is very beautiful. this is your work, Tnx very much',
        sender: 'Friend',
        timestamp: DateTime.now(),
      ),
      ChatMessage(
        text: 'Hello my name is bereket sewnet',
        sender: 'Friend',
        timestamp: DateTime.now(),
      ),
      ChatMessage(
        text:
            'Hello, My name is Betelhem sewnet',
        sender: 'Me',
        timestamp: DateTime.now().add(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text:
            'Ok, I\'am testing my chat app',
        sender: 'Me',
        timestamp: DateTime.now().add(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text:
        'Nice that\'s sounds grate',
        sender: 'Friend',
        timestamp: DateTime.now(),
      )
    ];
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        backgroundColor: CustomColors.secondaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.thirdColor,
          ),
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/images/profile.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Bereket Sewnet',
              style: TextStyle(
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
                  margin: EdgeInsets.only(bottom: 20),
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
                    onTap: () {},
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
}
// Container(
// width: 200,
// child: Card(
// margin:
// EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// child: ListTile(
// title: Text(message.text),
// subtitle: Text(
// '${message.sender} • ${message.timestamp}',
// ),
// ),
// ),
// ),
