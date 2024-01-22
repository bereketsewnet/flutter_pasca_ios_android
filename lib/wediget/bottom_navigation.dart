import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/pages/student_page/calendar.dart';
import 'package:pasca/pages/student_page/general_knwoledge_question.dart';
import 'package:pasca/pages/student_page/library.dart';
import 'package:pasca/pages/student_page/student_home_page.dart';

import '../pages/common_page/login_page.dart';
import '../pages/student_page/law.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const StudentHomePage(),
    const Library(),
    const Question(),
    const Law(),
    const Calendar(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: height / 35,
          right: width / 25,
          left: width / 25,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: CustomColors.thirdColor,
            // Set the background color
            selectedItemColor: CustomColors.primaryColor,
            // Set the selected icon and text color
            unselectedItemColor: CustomColors.secondaryColor,
            // Set the unselected icon and text color
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            // Set the selected label text style
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/images/home.png'),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/images/library.png'),
                ),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/images/question.png'),
                ),
                label: 'Question',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/images/calendar.png'),
                ),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/images/law.png'),
                ),
                label: 'Law',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
