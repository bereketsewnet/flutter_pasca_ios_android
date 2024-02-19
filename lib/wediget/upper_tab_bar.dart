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
  bool isMoreOneUnread = false;
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
      //Tab(text: 'Private $unreadCount'),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Private',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Visibility(
              visible: isMoreOneUnread,
              child: const SizedBox(width: 8),
            ),
            Visibility(
              visible: isMoreOneUnread,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: CustomColors.colorFour,
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                      fontSize: 12, color: CustomColors.secondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
       Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Public',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Visibility(
              visible: isMoreOneUnread,
              child: const SizedBox(width: 8),
            ),
            Visibility(
              visible: isMoreOneUnread,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: CustomColors.colorFour,
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                      fontSize: 12, color: CustomColors.secondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
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
          backgroundColor: CustomColors.secondaryColor,
          titleSpacing: 5.0,
         // elevation: 5,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_rounded,
              color: CustomColors.thirdColor,
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    profilePic.isNotEmpty ? NetworkImage(profilePic) : null,
                backgroundColor: Colors.transparent,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: CustomColors.thirdColor,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Class: $grade',
                        style: const TextStyle(
                          color: CustomColors.thirdColor,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: CustomColors.thirdColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
                color: CustomColors.thirdColor,
              ),
            ),
          ],
          bottom: TabBar(
            tabs: myTabs,
            isScrollable: true,
            indicator: const UnderlineTabIndicator(
              insets: EdgeInsets.symmetric(horizontal: 5.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              borderSide: BorderSide(
                width: 5.0,
                color: CustomColors.colorFour,
              ),
            ),
            dividerColor: Colors.transparent,
            labelColor: CustomColors.colorFour,
            unselectedLabelColor: CustomColors.colorFive,
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
        if (unreadCount > 0) {
          isMoreOneUnread = true;
        }
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
          if (unreadCount > 0) {
            isMoreOneUnread = true;
            initializeTabs();
          }
          initializeTabs();
        });
      }
    });
  }
}
