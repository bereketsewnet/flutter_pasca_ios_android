import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'package:pasca/pages/student_page/law.dart';
import 'package:pasca/pages/student_page/subject_user_list.dart';
import 'package:pasca/wediget/custom_button.dart';

import 'package:pasca/wediget/normal_button.dart';
import 'package:pasca/wediget/upper_tab_bar.dart';

import '../../wediget/snack_bar.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String name = '';
  String grade = '';
  String profilePic = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String _name = await SharedPref().getName() ?? '';
    String _grade = await SharedPref().getGrade() ?? '';
    String _profilePic = await SharedPref().getProfilePic() ??
        'https://firebasestorage.googleapis.com/v0/b/pasca-ios-and-android-dc988.appspot.com/o/Leonardo_Diffusion_XL_very_beutifull_computer_programming_setu_7.jpg?alt=media&token=7c164fff-c657-40f7-9219-bbd587c36138';
    // Once the values are retrieved, you can update your UI or perform any other actions
    setState(() {
      name = _name;
      grade = _grade;
      profilePic = _profilePic;
    });
  }

  //image slider of profile card list of images
  List imageList = [
    {"id": 1, "image_path": 'lib/assets/images/student_image.jpg'},
    {"id": 2, "image_path": 'lib/assets/images/image2.jpeg'},
    {"id": 3, "image_path": 'lib/assets/images/image3.png'},
    {"id": 4, "image_path": 'lib/assets/images/image4.jpg'},
    {"id": 5, "image_path": 'lib/assets/images/image5.jpg'},
    {"id": 6, "image_path": 'lib/assets/images/image6.jpg'},
    {"id": 7, "image_path": 'lib/assets/images/image7.jpg'},
    {"id": 8, "image_path": 'lib/assets/images/image8.jpg'},
    {"id": 9, "image_path": 'lib/assets/images/image9.jpg'},
  ];

  // List of addition feuther card Container list slider
  final List<Map<String, dynamic>> containerList = [
    {
      'image': 'lib/assets/images/map.jpg',
      'text': 'School Map',
      'route': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Law()), // Replace with your desired destination page
        );
      },
    },
    {
      'image': 'lib/assets/images/advert2.jpg',
      'text': 'School Info',
      'route': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Law()), // Replace with your desired destination page
        );
      },
    },
    {
      'image': 'lib/assets/images/ai.jpg',
      'text': 'AI',
      'route': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Law()), // Replace with your desired destination page
        );
      },
    },
  ];

  final CarouselController carouselController = CarouselController();
  final CarouselController carouselControllerLowerSlider = CarouselController();
  int currentIndex = 0;
  int currentIndexLowerSlider = 0;

  @override
  Widget build(BuildContext context) {
    // get all width and height of current screen
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // the upper part of the app 1/3 ratio
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: h / 4,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CarouselSlider(
                        items: imageList
                            .map(
                              (item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            }),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 120,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 17 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? CustomColors.thirdColor
                                      : CustomColors.primaryColor),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 100,
                              margin: const EdgeInsets.only(left: 20, top: 30),
                              color: CustomColors.thirdColor,
                              child: const Center(
                                child: Text(
                                  'Welcome',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(''),
                            ),
                            Container(
                              width: 65,
                              height: 65,
                              margin: const EdgeInsets.only(
                                  right: 15, bottom: 5, top: 20),
                              child: CircleAvatar(
                                radius: 50, // Adjust the radius as needed
                                backgroundImage: NetworkImage(profilePic),
                                backgroundColor: Colors
                                    .transparent, // Provide the image path
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            grade,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: h / 4.3,
              decoration: BoxDecoration(
                color: CustomColors.thirdColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpperTabBar(),
                            ),
                          );
                        },
                        imagePath: 'lib/assets/images/daily.png',
                        buttonText: 'Daily',
                      ),
                      CustomButton(
                        onPressed: () {},
                        imagePath: 'lib/assets/images/report.png',
                        buttonText: 'Report',
                      ),
                      CustomButton(
                        onPressed: () {},
                        imagePath: 'lib/assets/images/attendance.png',
                        buttonText: 'Attendance',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () {},
                        imagePath: 'lib/assets/images/fees.png',
                        buttonText: 'Fee-Info',
                      ),
                      CustomButton(
                        onPressed: () {},
                        imagePath: 'lib/assets/images/id.png',
                        buttonText: 'Teachers',
                      ),
                      CustomButton(
                        onPressed: () {},
                        imagePath: 'lib/assets/images/comments.png',
                        buttonText: 'Comments',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: h / 150),
            SizedBox(
              width: double.infinity,
              height: h / 3.4,
              child: Center(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CarouselSlider(
                        items: containerList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.secondaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            item['text'],
                                            style: const TextStyle(
                                              color: CustomColors.fourthColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          MyButton(
                                            onTap: () {
                                              item['route'](
                                                  context); // Call the route function with the context parameter
                                            },
                                            btn_txt: 'Explore',
                                            marginSize: 10,
                                            paddingSize: EdgeInsets.all(5),
                                            back_btn: CustomColors.thirdColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                        child: Image.asset(
                                          item['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                        carouselController: carouselControllerLowerSlider,
                        options: CarouselOptions(
                            reverse: true,
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 0.7,
                            height: 130,
                            initialPage: 2,
                            pauseAutoPlayOnTouch: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndexLowerSlider = index;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
