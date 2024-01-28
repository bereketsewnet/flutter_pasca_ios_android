import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pasca/code_test.dart';
import 'package:pasca/pages/common_page/all_users_list.dart';
import 'package:pasca/pages/common_page/login_page.dart';
import 'package:pasca/pages/common_page/register_page.dart';
import 'package:pasca/pages/student_page/chat_room.dart';
import 'package:pasca/pages/student_page/student_home_page.dart';
import 'package:pasca/pages/student_page/subject_user_list.dart';
import 'package:pasca/wediget/bottom_navigation.dart';
import 'package:pasca/wediget/upper_tab_bar.dart';


import 'firebase_service/fetch_user_data_and_chat_message.dart';
import 'methods/firebase_service/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: UpperTabBar(),
    );
  }
}
