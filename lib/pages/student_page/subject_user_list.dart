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
  List<Map<String, dynamic>> filterChatingFinal = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    startChatUser();
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
          return StartchatUserList(starttingChatUsers);
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

  void startChatUser(){
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

    List<Map<String, dynamic>> _chatingUserListFull = [];
    Query query = _dbRef.child('Chats').orderByChild('timeStamp');

    query.onValue.listen((event) {
      List<Map<String, dynamic>> _chatingUserList = [];
      _chatingUserList.clear(); // Clear the list before adding new values

      Map chatingUser = event.snapshot.value as Map;


        List<MapEntry<dynamic, dynamic>> entries = chatingUser.entries.toList();

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
          if (value['sender'] == uid || value['receiver'] == uid) {
            _chatingUserList.add(value);

          }
        }
        // start doing reverse the list. b/c the order is set by older to latest so i want to first latest
      _chatingUserList = _chatingUserList.reversed.toList();
        // and after reverse i need to remove duplicated id. b/c no need of duplicated user
      Set<String> uniqueIds = Set<String>();
      List<Map<String, dynamic>> newList = [];

      for (Map<String, dynamic> user in _chatingUserList) {
        String friend;
        if(user['sender'] == uid){
          friend = user['receiver'];
        }else{
          friend = user['sender'];
        }

        // Check if the ID is already present in the set
        if (!uniqueIds.contains(friend)) {
          // If not, add it to the set and include the user in the new list
          uniqueIds.add(friend);
          newList.add(user);
        }
        // If the ID is already present, it's a duplicate and can be skipped
      }

      // Update the original list with the new list
      _chatingUserList.clear();
      _chatingUserList.addAll(newList);
      for (int i = 0; i < _chatingUserList.length; i++) {
        // Process the filtered and ordered data here
        String friend;
        if(_chatingUserList[i]['sender'] == uid){
          friend = _chatingUserList[i]['receiver'];
        }else{
          friend = _chatingUserList[i]['sender'];
        }
        Map<String , dynamic> chatInfo = {
          'message' : _chatingUserList[i]['message'],
          'timeStamp' : _chatingUserList[i]['timeStamp'],
          'friend' : friend,

        };
        _chatingUserListFull.add(chatInfo);
      }


    });

    final DatabaseReference dbRefUser =
    FirebaseDatabase.instance.reference().child('users');

    dbRefUser.once().then((event) {
      if (event.snapshot.value != null) {
        List<Map<String, dynamic>> usersListR = [];
        Map usersMap = event.snapshot.value as Map;

        usersMap.forEach((key, value) {
          // Assuming that each user has keys like 'email', 'name', 'password', etc.
          Map<String, dynamic> user = Map<String, dynamic>.from(value);
          usersListR.add(user);
        });
        List<Map<String, dynamic>> tempList = [];
        tempList.clear();
        for(int i = 0; i < usersListR.length; i++){
          for(int j = 0; j < _chatingUserListFull.length; j++){
            if(usersListR[i]['uid'] == _chatingUserListFull[j]['friend']){
              Map<String, dynamic> temp = {
                'name': usersListR[i]['name'],
                'profilePic': usersListR[i]['profilePic'],
                'message': _chatingUserListFull[j]['message'],
                'timeStamp': _chatingUserListFull[j]['timeStamp'],
                'friend': _chatingUserListFull[j]['friend'],
              };
              tempList.add(temp);
            }
          }
        }
        setState(() {
          filterChatingFinal = tempList;
        });
      }

    });

  }
}
