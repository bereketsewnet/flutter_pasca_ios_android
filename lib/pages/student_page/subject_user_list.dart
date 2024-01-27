import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/snack_bar.dart';
import 'package:pasca/wediget/user_list_view.dart';

import '../../methods/my_methods/shared_pref_method.dart';
import '../../wediget/floting_action_buttom.dart';
import '../../wediget/user_chat_list_view.dart';

class SubjectUserList extends StatefulWidget {
  const SubjectUserList({Key? key}) : super(key: key);

  @override
  State<SubjectUserList> createState() => _SubjectUserListState();
}

class _SubjectUserListState extends State<SubjectUserList> {
  String uid = '';
  String friedId = '';
  List<Map<String, dynamic>> filterChatingFinal = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetch_starting_chat_user();
  }

  void fetchData() async {
    //geting my uId
    String _uid = await SharedPref().getUid() ?? '';
    setState(() {
      uid = _uid;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: ListView.builder(
        itemCount: filterChatingFinal.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> starttingChatUsers = filterChatingFinal[index];
          return buildChatCard(starttingChatUsers);
        },
      ),
      floatingActionButton: FlotingButtom(
        color: CustomColors.thirdColor,
        icon: const Icon(
          Icons.edit,
          color: CustomColors.primaryColor,
        ),
      ),
    );
  }

// get the who start chat with me and filter it by list of map
Future<void> fetch_starting_chat_user() async {
  final DatabaseReference dbRefChat =
      FirebaseDatabase.instance.reference().child("Chats");
  final DatabaseReference dbRefUser =
      FirebaseDatabase.instance.reference().child('users');
  List<Map<String, dynamic>> chatingUserList = [];


  // getting all chat message that receive and send by me
 await dbRefChat.onValue.listen((event) {
    if (event.snapshot.value != null) {
      List<Map<String, dynamic>> chats = [];
      Map values = event.snapshot.value as Map;
      values.forEach((key, value) {
        chats.add(Map<String, dynamic>.from(value));
      });
      //// if we get all chat message next check sender or receiver is me b/c that means we start chat
      List<Map<String, dynamic>> chatingUserListR = [];
      chatingUserListR.clear();
      for (int i = 0; i < chats.length; i++) {
        if (chats[i]['sender'] == uid || chats[i]['receive'] == uid) {
          String friend;
          if (chats[i]['sender'] == uid) {
            friend = chats[i]['receiver'];
          } else {
            friend = chats[i]['sender'];
          }
          Map<String, dynamic> chatingUser = {
            'message': chats[i]['message'],
            'timeStamp': chats[i]['timeStamp'],
            'friend': friend,
          };
          chatingUserListR.add(chatingUser);
        }
      }
      setState(() {
        chatingUserList = chatingUserListR;
      });
    }
  });
  // geting filter only Chat with me contact not duplicated user
 await dbRefUser.onValue.listen((event){
    if (event.snapshot.value != null) {
      List<Map<String, dynamic>> usersListR = [];
      Map usersMap = event.snapshot.value as Map;

      usersMap.forEach((key, value) {
        // Assuming that each user has keys like 'email', 'name', 'password', etc.
        Map<String, dynamic> user = Map<String, dynamic>.from(value);
        usersListR.add(user);
      });
      // createing getting receiver for loop map variable
      List<Map<String, dynamic>> filterChatingFinalR = [];
      filterChatingFinalR.clear();
      // checking userid = starting chat friend id. b/c to get name and profile pic from that id then display in to start chat page
      for (int i = 0; i < usersListR.length; i++) {
        for (int ii = 0; ii < chatingUserList.length; ii++) {
          if (usersListR[i]['uid'] == chatingUserList[ii]['friend']) {

            Map<String, dynamic> filterUser = {
              'uid' : usersListR[i]['uid'],
              'name': usersListR[i]['name'],
              'profilePic': usersListR[i]['profilePic'],
              'message': chatingUserList[ii]['message'],
              'timeStamp': chatingUserList[ii]['timeStamp'],
            };
            filterChatingFinalR.add(filterUser);
          }
        }
      }
      setState(() {
        filterChatingFinal = filterChatingFinalR;
      });
    }
  });
}

  // Future<List<Map<String, dynamic>>> fetchStartingChatUser() async {
  //   final DatabaseReference dbRefChat =
  //   FirebaseDatabase.instance.reference().child("Chats");
  //   final DatabaseReference dbRefUser =
  //   FirebaseDatabase.instance.reference().child('users');
  //   List<Map<String, dynamic>> chatingUserList = [];
  //   List<Map<String, dynamic>> filterChatingFinal = [];
  //
  //   // getting all chat messages that are sent or received by the user
  //   await dbRefChat.onValue.listen((event) async {
  //     if (event.snapshot.value != null) {
  //       List<Map<String, dynamic>> chats = [];
  //       Map values = event.snapshot.value as Map;
  //       values.forEach((key, value) {
  //         chats.add(Map<String, dynamic>.from(value));
  //       });
  //
  //       // check if sender or receiver is the user to determine if it's a chat with the user
  //       List<Map<String, dynamic>> chatingUserListR = [];
  //       chatingUserListR.clear();
  //       for (int i = 0; i < chats.length; i++) {
  //         if (chats[i]['sender'] == uid || chats[i]['receive'] == uid) {
  //           String friend;
  //           if (chats[i]['sender'] == uid) {
  //             friend = chats[i]['receiver'];
  //           } else {
  //             friend = chats[i]['sender'];
  //           }
  //           Map<String, dynamic> chatingUser = {
  //             'message': chats[i]['message'],
  //             'timeStamp': chats[i]['timeStamp'],
  //             'friend': friend,
  //           };
  //           chatingUserListR.add(chatingUser);
  //         }
  //       }
  //       chatingUserList = chatingUserListR;
  //     }
  //   }).asFuture();
  //
  //   // get users from the database
  //   await dbRefUser.onValue.listen((event) async {
  //     if (event.snapshot.value != null) {
  //       List<Map<String, dynamic>> usersListR = [];
  //       Map usersMap = event.snapshot.value as Map;
  //
  //       usersMap.forEach((key, value) {
  //         // Assuming that each user has keys like 'uid', 'name', 'profilePic', etc.
  //         Map<String, dynamic> user = Map<String, dynamic>.from(value);
  //         usersListR.add(user);
  //       });
  //
  //       // filter users based on chatingUserList
  //       List<Map<String, dynamic>> filterChatingFinalR = [];
  //       filterChatingFinalR.clear();
  //       for (int i = 0; i < usersListR.length; i++) {
  //         for (int ii = 0; ii < chatingUserList.length; ii++) {
  //           if (usersListR[i]['uid'] == chatingUserList[ii]['friend']) {
  //             Map<String, dynamic> filterUser = {
  //               'uid': usersListR[i]['uid'],
  //               'name': usersListR[i]['name'],
  //               'profilePic': usersListR[i]['profilePic'],
  //               'message': chatingUserList[ii]['message'],
  //               'timeStamp': chatingUserList[ii]['timeStamp'],
  //             };
  //             filterChatingFinalR.add(filterUser);
  //           }
  //         }
  //       }
  //       filterChatingFinal = filterChatingFinalR;
  //     }
  //   }).asFuture();
  //   showSnackBar(context, filterChatingFinal[0]['name']);
  //   return filterChatingFinal;
  // }

}
