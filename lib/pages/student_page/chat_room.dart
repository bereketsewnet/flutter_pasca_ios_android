import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'package:pasca/wediget/chat_messages_list.dart';
import 'package:pasca/wediget/snack_bar.dart';

import '../../firebase_service/storage/upload_data.dart';
import '../../methods/my_methods/check_internt_status.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final Query _dbRef = FirebaseDatabase.instance.ref().child('Chats');
  String uid = '';
  List<Map<String, dynamic>> chatMessageList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    fetchData();
    readMessage();
    // Set up the onChildAdded listener
    _dbRef.onChildAdded.listen((event) {
      // Handle the new child node added
      scrollToBottom();
    //  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    checkConnectivity();
  }

  void fetchData() async {
    String _uid = await SharedPref().getUid() ?? '';
    // check profile pic is defalut one

    // getting my id
    setState(() {
      uid = _uid;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                  widget.profileImage), // get profile from chat list
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.friendName, // get name from chat list
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
            child: chatMessageList.isNotEmpty
                ? ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatMessageList.length,
                    itemBuilder: (contex, index) {
                      Map<dynamic, dynamic> users = chatMessageList[index];
                      // check message sender to my id b/c to put on the right side ot message
                      final bool isMe = users['sender'] == uid;
                      final bool isSeen = users['isSeen'] == true;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: ChatMessageList(
                          // this is list item inside containt if it is me change border, alignment , and color based on bool answer
                          message: users['message'],
                          timeStamp: users['timeStamp'],
                          RBL: isMe ? 10 : 0,
                          RBR: isMe ? 0 : 10,
                          isIconVisible: isMe ? true : false,
                          seenIcon: isSeen
                              ? const Icon(
                                  Icons.done_all,
                                  color: CustomColors.thirdColor,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.done,
                                  color: CustomColors.thirdColor,
                                  size: 20,
                                ),
                          Margin: isMe
                              ? const EdgeInsets.only(
                                  left: 40,
                                  top: 5,
                                  right: 8,
                                  bottom: 3,
                                )
                              : const EdgeInsets.only(
                                  right: 40,
                                  top: 10,
                                  left: 8,
                                  bottom: 3,
                                ),
                          backColor: isMe
                              ? CustomColors.secondaryColor
                              : CustomColors.thirdColor,
                          textColor: isMe
                              ? CustomColors.thirdColor
                              : CustomColors.secondaryColor,
                          inSideContaintAlign: isMe
                              ? const Alignment(1, 0)
                              : const Alignment(-1, 0),
                        ),
                      );
                    },
                  )
                : Container(),
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
                        onPressed: (){
                          insetImageGalleryForProfile(context, uid);
                        },
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

  void readMessage() {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
    List<Map<String, dynamic>> chatMessageListR = [];

    dbRef.child('Chats').orderByChild('timeStamp').onValue.listen((event) {
      Map<dynamic, dynamic> chatMessage =
          event.snapshot.value as Map<dynamic, dynamic>;
      chatMessageList.clear();
      chatMessageListR.clear();
      List<MapEntry<dynamic, dynamic>> entries = chatMessage.entries.toList();

      entries.sort((a, b) {
        // Compare the "timeStamp" values for sorting
        int timeStampA = a.value['timeStamp'];
        int timeStampB = b.value['timeStamp'];
        return timeStampA.compareTo(timeStampB);
      });
      for (int i = 0; i < entries.length; i++) {
        MapEntry<dynamic, dynamic> entry = entries[i];
        Map<String, dynamic> value = Map<String, dynamic>.from(entry.value);
        // get user that sender is me or the message receive to me
        if (value['sender'] == uid && value['receiver'] == widget.friendId ||
            value['sender'] == widget.friendId && value['receiver'] == uid) {
          chatMessageListR.add(value);
        }
        setState(() {
          chatMessageList = chatMessageListR;
          checkSeenMessage();
        });
      }
    }).onError((error) {
      showSnackBar(context, error.toString());
    });
  }

  Future<void> sendMessage() async {
    // geting all nessasry info for send message e.g uid, friendId, message,date,database e.t.c .....
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    String friendId = widget.friendId;
    String message = _messageController.text;
    String myId = await SharedPref().getUid() ?? uid;
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('Chats').push();
    String? messageKey = dbRef.key;
    if (message.isNotEmpty && message != ' ' && message != '  ') {
      // chat info map or object
      Map<String, dynamic> chatData = {
        'message': message,
        'sender': myId,
        'isSeen': false,
        'receiver': friendId,
        'timeStamp': ServerValue.timestamp,
        'refkey': messageKey,
      };
      // inserting chat data
      await dbRef.set(chatData).then((_) {
        // handle code when data inserted
        setState(() {
          _messageController.clear();
        });
      }).catchError((error) {
        showSnackBar(context, 'Error inserting data: $error');
      });
    }
  }

  Future<void> scrollToBottom() async {
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

    await Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    });
  }

  void checkSeenMessage() {
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('Chats');

    // check all the list sender is my friend and receiver is me the chat update to isSeen ture;
    for (int i = 0; i < chatMessageList.length; i++) {
      if (chatMessageList[i]['sender'] == widget.friendId &&
          chatMessageList[i]['receiver'] == uid) {
        String messageKey = chatMessageList[i]['refkey'];
        // update by the getting the key to true
        _dbRef.child(messageKey).update({'isSeen': true});
      }
    }
  }
}
