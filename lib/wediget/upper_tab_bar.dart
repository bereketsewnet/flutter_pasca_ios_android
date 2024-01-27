import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'package:pasca/pages/common_page/all_users_list.dart';
import 'package:pasca/pages/student_page/law.dart';
import 'package:pasca/pages/student_page/subject_user_list.dart';
import 'package:pasca/wediget/user_list_view.dart';

class UpperTabBar extends StatefulWidget {
  @override
  State<UpperTabBar> createState() => _UpperTabBarState();
}

class _UpperTabBarState extends State<UpperTabBar> {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Private'),
    const Tab(text: 'Public'),
  ];

  String name = '';
  String grade = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String fetchedName = await SharedPref().getName() ?? '';
    String fetchedGrade = await SharedPref().getGrade() ?? '';

    setState(() {
      name = fetchedName;
      grade = fetchedGrade;
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
                      style: TextStyle(color: CustomColors.thirdColor, fontSize: 14),
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
                width: 4.0,
                color: CustomColors.fourthColor,
              ),
              insets: EdgeInsets.symmetric(horizontal: 26.0),
            ),
            labelColor: CustomColors.thirdColor,

          ),
        ),
        body: const TabBarView(
          children: [
            AllUsersList(),
            Law(),
          ],
        ),
      ),
    );
  }
}
