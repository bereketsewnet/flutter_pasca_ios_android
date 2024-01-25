import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/user_list_view.dart';

import '../../wediget/floting_action_buttom.dart';
import '../../wediget/user_chat_list_view.dart';

class SubjectUserList extends StatelessWidget {
  const SubjectUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Query _dbRef = FirebaseDatabase.instance.ref().child('users');
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        child: FirebaseAnimatedList(
          query: _dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map users = snapshot.value as Map;
            return UsersListView(users: users);
          },
        ),
      ),
      floatingActionButton: FlotingButtom(
        color: CustomColors.secondaryColor,
        icon: Icon(
          Icons.edit,
          color: CustomColors.thirdColor,
        ),
      ),
    );
  }
}
