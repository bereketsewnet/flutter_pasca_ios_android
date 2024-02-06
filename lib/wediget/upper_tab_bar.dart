import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'package:pasca/pages/common_page/all_users_list.dart';
import 'package:pasca/pages/student_page/law.dart';
import 'package:pasca/pages/student_page/subject_user_list.dart';

class UpperTabBar extends StatefulWidget {
  @override
  State<UpperTabBar> createState() => _UpperTabBarState();
}

class _UpperTabBarState extends State<UpperTabBar> {
  late List<Tab> myTabs;

  String name = '';
  String grade = '';
  String uid = '';
  String profilePic = '';
  int unreadCount = 0;
  List<Map<dynamic, dynamic>> counterList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    countUnreadMessage();
    initializeTabs();
  }

  void initializeTabs() {
    myTabs = [
      Tab(text: 'Private $unreadCount'),
      const Tab(text: 'Public'),
    ];
  }

  void fetchData() async {
    String fetchedName = await SharedPref().getName() ?? '';
    String fetchedGrade = await SharedPref().getGrade() ?? '';
    String fetchedUid = await SharedPref().getUid() ?? '';
    String fetchProfilePic = await SharedPref().getProfilePic() ?? '';

    setState(() {
      name = fetchedName;
      grade = fetchedGrade;
      uid = fetchedUid;
      profilePic = fetchProfilePic;
    });
  }

  @override
  Widget build(BuildContext context) {
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
               CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(profilePic),
                 backgroundColor: Colors.transparent,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: CustomColors.thirdColor, fontSize: 18),
                    ),
                    Text(
                      'Class: $grade',
                      style: const TextStyle(
                          color: CustomColors.thirdColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: CustomColors.primaryColor,
          bottom: TabBar(
            tabs: myTabs,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: CustomColors.thirdColor,
              ),
              insets: EdgeInsets.symmetric(horizontal: 100),
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

  void countUnreadMessage() {
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
    List<Map<dynamic, dynamic>> counterListR = [];
    counterListR.clear();

    _dbRef.child('Chats').once().then((event) {
      Map<dynamic, dynamic> counter = event.snapshot.value as Map;

      counter.forEach((key, value) {
        if (value['receiver'] == uid && value['isSeen'] == false) {
          counterListR.add(Map<dynamic, dynamic>.from(value));
        }
      });

      setState(() {
        unreadCount = counterListR.length;
        initializeTabs(); // Update the tabs with the new unread count
        counterList = counterListR;
      });
    }).catchError((error) {});

    // Also listen for changes in the database and update the count accordingly
    _dbRef.child('Chats').onChildChanged.listen((event) {
      // You can check if the changed message is related to the current user and update the count
      // Example: If the message is marked as read, decrement the unreadCount
      // Update the logic based on your database structure and how you mark messages as read
      // For demonstration purposes, assuming there's an 'isSeen' field in the message
      Map<dynamic, dynamic> changedMessage = event.snapshot.value as Map;
      if (changedMessage['receiver'] == uid &&
          changedMessage['isSeen'] == true) {
        setState(() {
          unreadCount--; // Decrease the count as the message is marked as seen
          // countUnreadMessage();
          initializeTabs();
        });
      }
    });
  }
}
