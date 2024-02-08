import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pasca/pages/common_page/login_page.dart';
import 'package:pasca/pages/common_page/register_page.dart';
import 'package:pasca/pages/student_page/student_home_page.dart';
import 'package:pasca/pages/student_page/subject_user_list.dart';
import 'package:pasca/wediget/bottom_navigation.dart';
import 'package:pasca/wediget/upper_tab_bar.dart';
import 'code_test.dart';
import 'methods/firebase_service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDL8gqF8DVeVhBguAfqJB4UGi51mFxTvMw',
    appId: '1:824091918512:ios:4ace7276b85a73aa267b75',
    messagingSenderId: '824091918512',
    projectId: 'pasca-ios-and-android-dc988',
    storageBucket: 'pasca-ios-and-android-dc988.appspot.com',
    iosBundleId: 'com.example.pasca',
        databaseURL: 'https://pasca-ios-and-android-dc988-default-rtdb.firebaseio.com/'
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}
