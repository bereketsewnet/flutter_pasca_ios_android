import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/user_list_view.dart';

import '../../methods/my_methods/shared_pref_method.dart';
import '../../wediget/floting_action_buttom.dart';
import '../../wediget/user_chat_list_view.dart';

class AllUsersList extends StatefulWidget {
  const AllUsersList({Key? key}) : super(key: key);

  @override
  State<AllUsersList> createState() => _AllUsersListState();
}

class _AllUsersListState extends State<AllUsersList> {
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
    final Query _dbRef = FirebaseDatabase.instance.ref().child('users');

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
            if(users['uid'] != uid){
              return UsersListView(users: users);
            }
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
}
