import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'package:pasca/pages/common_page/all_users_list.dart';
import 'package:pasca/pages/student_page/law.dart';
import 'package:pasca/pages/student_page/subject_user_list.dart';
import 'package:pasca/wediget/snack_bar.dart';
import 'package:pasca/wediget/user_list_view.dart';

class UpperTabBar extends StatefulWidget {
  @override
  State<UpperTabBar> createState() => _UpperTabBarState();
}

class _UpperTabBarState extends State<UpperTabBar> {
  late List<Tab> myTabs;

  String name = '';
  String grade = '';
  String uid = '';
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    countUnreadMessage();
    initializeTabs();
  }

  void initializeTabs() {
    myTabs = [
      Tab(text: 'Private-$unreadCount'),
      const Tab(text: 'Public'),
    ];
  }

  void fetchData() async {
    String fetchedName = await SharedPref().getName() ?? '';
    String fetchedGrade = await SharedPref().getGrade() ?? '';
    String fetchedUid = await SharedPref().getUid() ?? '';

    setState(() {
      name = fetchedName;
      grade = fetchedGrade;
      uid = fetchedUid;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://www.catholicsingles.com/wp-content/uploads/2020/06/blog-header-3.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: CustomColors.thirdColor, fontSize: 18),
                    ),
                    Text(
                      'Class: $grade',
                      style: const TextStyle(color: CustomColors.thirdColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: CustomColors.primaryColor,
          bottom: TabBar(
            tabs: myTabs,
            indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(
                width: 2.0,
                color: CustomColors.thirdColor,
              ),
              insets: EdgeInsets.symmetric(horizontal: size.width / 10),
            ),
            labelColor: CustomColors.thirdColor,

          ),
        ),
        body: const TabBarView(
          children: [
            SubjectUserList(),
            AllUsersList(),
          ],
        ),
      ),
    );
  }
  void countUnreadMessage(){
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
    List<Map<dynamic,dynamic>> counterList = [];
    counterList.clear();

    _dbRef.child('Chats').once().then((event) {
      Map<dynamic, dynamic> counter = event.snapshot.value as Map;

      counter.forEach((key, value) {
        if(value['receiver'] == uid && value['isSeen'] == false){
          counterList.add(Map<dynamic, dynamic>.from(value));
        }
      });

     setState(() {
       unreadCount = counterList.length;
       initializeTabs(); // Update the tabs with the new unread count
     });



    }).catchError((error){

    });

    // Also listen for changes in the database and update the count accordingly
    _dbRef.child('Chats').onChildChanged.listen((event) {
      // You can check if the changed message is related to the current user and update the count
      // Example: If the message is marked as read, decrement the unreadCount
      // Update the logic based on your database structure and how you mark messages as read
      // For demonstration purposes, assuming there's an 'isSeen' field in the message
      Map<dynamic, dynamic> changedMessage = event.snapshot.value as Map;
      if (changedMessage['receiver'] == uid && changedMessage['isSeen'] == true) {
        setState(() {
          countUnreadMessage(); // Ensure unreadCount is not negative
          initializeTabs();
        });
      }
    });

  }
}
