import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/pages/common_page/all_users_list.dart';
import 'package:pasca/pages/student_page/student_home_page.dart';
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
        onPressed: () {
          showSnackBar(context, 'message');
        },
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
    await dbRefUser.once().then((event) {
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
                'uid': usersListR[i]['uid'],
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
          removeDuplicateIds();
        });
      }
    });
  }

  void removeDuplicateIds()   {
    Set<String> uniqueIds = Set<String>();
    List<Map<String, dynamic>> newList = [];

    for (Map<String, dynamic> user in filterChatingFinal) {
      String uid = user['uid'];

      // Check if the ID is already present in the set
      if (!uniqueIds.contains(uid)) {
        // If not, add it to the set and include the user in the new list
        uniqueIds.add(uid);
        newList.add(user);
      }
      // If the ID is already present, it's a duplicate and can be skipped
    }

    // Update the original list with the new list
    filterChatingFinal.clear();
    filterChatingFinal.addAll(newList);
  }
}
