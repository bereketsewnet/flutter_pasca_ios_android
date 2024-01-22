import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'assets/custom_colors/colors.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List imageList = [
    {"id": 1, "image_path": 'lib/assets/images/student_image.jpg'},
    {"id": 2, "image_path": 'lib/assets/images/image2.jpg'},
    {"id": 3, "image_path": 'lib/assets/images/image3.jpg'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Column(
        children: [
          SafeArea(
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    print(currentIndex);
                  },
                  child: CarouselSlider(
                    items: imageList.map(
                      (item) => Image.asset(
                        item['image_path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ).toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason){
                        setState(() {
                          currentIndex = index;
                        });
                      }
                    ),
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
                          margin: const EdgeInsets.only(left: 20),
                          color: CustomColors.thirdColor,
                          child: const Center(
                            child: Text(
                              'Welcome',
                              style: TextStyle(color: Colors.white,fontSize: 14),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(''),
                        ),
                        Container(
                          width: 65,
                          height: 65,
                          margin: const EdgeInsets.only(right: 15, bottom: 5),
                          child: const CircleAvatar(
                            radius: 50, // Adjust the radius as needed
                            backgroundImage: AssetImage(
                                'lib/assets/images/profile.png'), // Provide the image path
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Student Full Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Student Class',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
