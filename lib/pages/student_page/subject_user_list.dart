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

  @override
  void initState() {
    super.initState();
    fetchData();
    fetch_user_and_message();
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
    final Query _dbRefUsers = FirebaseDatabase.instance.ref().child('users');

    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: FirebaseAnimatedList(
          query: _dbRefUsers,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map users = snapshot.value as Map;

            return Container();
          },
        ),
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

  void fetch_user_and_message() {
    final DatabaseReference dbRefChat =
        FirebaseDatabase.instance.reference().child("Chats");
    final DatabaseReference dbRefUser =
        FirebaseDatabase.instance.reference().child('users');
    List<Map<String, dynamic>> chatingUserList = [];

    // getting all chat message that receive and send by me
    dbRefChat.onValue.listen((event) {
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

    dbRefUser.onValue.listen((event) {
      if (event.snapshot.value != null) {
        List<Map<String, dynamic>> usersListR = [];
        Map usersMap = event.snapshot.value as Map;

        usersMap.forEach((key, value) {
          // Assuming that each user has keys like 'email', 'name', 'password', etc.
          Map<String, dynamic> user = Map<String, dynamic>.from(value);
          usersListR.add(user);
        });

        for(int i = 0; i < usersListR.length; i++){
          if(usersListR[i]['uid'] == chatingUserList[0]['friend']){

          }
        }
        // showSnackBar(context, usersList[2]['email']);
      }
    });
  }
}
