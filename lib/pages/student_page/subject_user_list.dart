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

  @override
  void initState() {
    super.initState();
    fetchData();
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
    final Query _dbRef =
        FirebaseDatabase.instance.ref().child('ChatList').child(uid);

    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: FirebaseAnimatedList(
          query: _dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map users = snapshot.value as Map;
            // check if the user is equal to my id not display b/c i not chat my self and will return null container
            // if(users['friendId'] != uid){
            //   return UsersListView(users: users);
            // }
            // Extract and store the friendIds in a list of strings
            List<String> friendIdsList = [];
            users.forEach((friendId, value) {
              friendIdsList.add(friendId);
              print(friendId);
            });
            return Center(
              child: Container(
                child: Text(
                  ';kj',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
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
}
