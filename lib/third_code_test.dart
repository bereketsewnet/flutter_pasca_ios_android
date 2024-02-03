








// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:pasca/assets/custom_colors/colors.dart';
// import 'package:pasca/methods/my_methods/shared_pref_method.dart';
// import 'package:pasca/wediget/chat_messages_list.dart';
// import 'package:pasca/wediget/snack_bar.dart';
//
// import '../../second_code_test.dart';
//
// class ChatRoomTest extends StatefulWidget {
//   String friendId;
//   String profileImage;
//   String friendName;
//
//   ChatRoomTest({
//     required this.friendId,
//     required this.profileImage,
//     required this.friendName,
//   });
//
//   @override
//   State<ChatRoomTest> createState() => _ChatRoomTestState();
// }
//
// class _ChatRoomTestState extends State<ChatRoomTest> {
//   final TextEditingController _messageController = TextEditingController();
//
//   String uid = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   void fetchData() async {
//     String _uid = await SharedPref().getUid() ?? '';
//     // Once the values are retrieved, you can update your UI or perform any other actions
//     setState(() {
//       uid = _uid;
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final Query _dbRef = FirebaseDatabase.instance.ref().child('Chats');
//     final List<ChatMessage> chatMessages = [
//       ChatMessage(
//         text: 'Hello',
//         sender: 'Me',
//         timestamp: DateTime.now(),
//       ),
//       ChatMessage(
//         text: 'Hi there!',
//         sender: 'Friend',
//         timestamp: DateTime.now().add(Duration(minutes: 5)),
//       ),
//       // Add more chat messages here
//     ];
//     return Scaffold(
//       backgroundColor: CustomColors.primaryColor,
//       appBar: AppBar(
//         backgroundColor: CustomColors.secondaryColor,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: CustomColors.thirdColor,
//           ),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(
//                   'https://firebasestorage.googleapis.com/v0/b/pasca-ios-and-android-dc988.appspot.com/o/Leonardo_Diffusion_XL_very_beutifull_computer_programming_setu_7.jpg?alt=media&token=7c164fff-c657-40f7-9219-bbd587c36138'), // get profile from chat list
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               widget.friendName, // get name from chat list
//               style: const TextStyle(
//                 color: CustomColors.thirdColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               child: FirebaseAnimatedList(
//                 query: _dbRef,
//                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                     Animation<double> animation, int index) {
//                   Map users = snapshot.value as Map;
//                   final bool isMe = users['uid'] == uid;
//
//                   return Align(
//                     alignment:
//                     isMe ? Alignment.centerRight : Alignment.centerLeft,
//                     child: ChatMessageList(
//                       // this is list item inside containt if it is me change border, alignment , and color based on bool answer
//                       message: users['message'],
//                       timeStamp: users['timeStamp'],
//                       RBL: isMe ? 20 : 3,
//                       RBR: isMe ? 3 : 20,
//                       backColor: isMe
//                           ? CustomColors.secondaryColor
//                           : CustomColors.fourthColor,
//                       textColor: isMe
//                           ? CustomColors.fourthColor
//                           : CustomColors.primaryColor,
//                       inSideContaintAlign:
//                       isMe ? const Alignment(1, 0) : const Alignment(-1, 0),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(
//                     right: 10,
//                     bottom: 20,
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                   ),
//                   width: size.width / 1.4,
//                   decoration: BoxDecoration(
//                     color: CustomColors.secondaryColor,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         spreadRadius: 5,
//                         blurRadius: 20,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: _messageController,
//                     style: const TextStyle(
//                       color: CustomColors.fourthColor,
//                     ),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       prefixIcon: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.photo_camera_outlined,
//                           color: CustomColors.thirdColor,
//                         ),
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.keyboard_voice_outlined,
//                           color: CustomColors.thirdColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         spreadRadius: 5,
//                         blurRadius: 20,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: InkWell(
//                     onTap: sendMessage,
//                     child: const CircleAvatar(
//                       backgroundColor: CustomColors.thirdColor,
//                       radius: 25,
//                       child: Icon(
//                         Icons.send_outlined,
//                         color: CustomColors.secondaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void sendMessage() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     String uid = user!.uid;
//     String friendId = widget.friendId;
//     String message = _messageController.text;
//     String myId = await SharedPref().getUid() ?? uid;
//     DateTime now = DateTime.now();
//     var format = DateFormat('yyyy-MM-dd HH:mm:ss');
//     String timeStamp = format.format(now);
//     DatabaseReference dbRefChat =
//     FirebaseDatabase.instance.ref().child('Chats');
//     DatabaseReference dbRefChatList = FirebaseDatabase.instance
//         .ref()
//         .child('ChatList')
//         .child(myId)
//         .child(friendId);
//
//     if (message.isNotEmpty && message != ' ' && message != '  ') {
//       // chat info map
//       Map<String, dynamic> chatData = {
//         'message': message,
//         'sender': myId,
//         'receiver': friendId,
//         'timeStamp': timeStamp,
//       };
//       // use for start chat map container myId child to friend Id
//       Map<String, dynamic> chatList = {
//         'friendId': friendId,
//       };
//       // inserting chat data
//       dbRefChat.push().set(chatData).then((_) {
//         // handle code when data inserted
//         _messageController.text = '';
//       }).catchError((error) {
//         showSnackBar(context, 'Error inserting data: $error');
//       });
//       // inserting chatList for the use of which one is start chating
//       dbRefChatList.set(chatList).then((_) {
//         // handle code when data inserted
//       }).catchError((error) {
//         showSnackBar(context, 'Error inserting data: $error');
//       });
//     }
//   }
// }
