import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pasca/code_test.dart';
import 'package:pasca/pages/common_page/login_page.dart';
import 'package:pasca/pages/common_page/register_page.dart';
import 'package:pasca/pages/student_page/student_home_page.dart';
import 'package:pasca/wediget/bottom_navigation.dart';

import 'firebase_service/firebase_options.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
    );
  }
}
