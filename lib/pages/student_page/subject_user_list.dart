import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/user_list_view.dart';

import '../../wediget/user_chat_list_view.dart';

class SubjectUserList extends StatelessWidget {
  const SubjectUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Query _dbRef = FirebaseDatabase.instance.ref().child('users');
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: CustomColors.thirdColor,
          ),
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://www.catholicsingles.com/wp-content/uploads/2020/06/blog-header-3.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              'BereketSewnet',
              style: TextStyle(color: CustomColors.thirdColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        child: FirebaseAnimatedList(
          query: _dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map users = snapshot.value as Map;
            return UsersListView(users: users);
          },
        ),
      ),
    );
  }
}
