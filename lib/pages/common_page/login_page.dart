import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pasca/pages/student_page/law.dart';
import 'package:pasca/wediget/bottom_navigation.dart';
import 'package:pasca/wediget/snack_bar.dart';

import '../../assets/custom_colors/colors.dart';
import '../../methods/my_methods/shared_pref_method.dart';
import '../../wediget/normal_button.dart';
import '../../wediget/normal_textfield.dart';
import '../student_page/calendar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// create coltroller to get the textfiled value
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
//create firebase instance of login method
final FirebaseAuth _auth = FirebaseAuth.instance;
String email = '', password = '';

// Declare a variable for showing/hiding the loading spinner
bool _isLoading = false;
bool _isObsecure = true;

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // get all screen size for resposible ui.
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: CustomColors.primaryColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: CustomColors.primaryColor,
          ),
          backgroundColor: CustomColors.primaryColor,
          elevation: 0,
          leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_back,
              color: CustomColors.thirdColor,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome Again',
                  style: TextStyle(
                    color: CustomColors.thirdColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              margin: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: MyTextField(
                controller: _emailController,
                keybordType: TextInputType.emailAddress,
                obscureText: false,
                lableText: 'E-Mail',
                prifixIcon: const Icon(
                  Icons.email,
                  color: CustomColors.thirdColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              margin: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: MyTextField(
                controller: _passwordController,
                keybordType: TextInputType.visiblePassword,
                obscureText: _isObsecure,
                lableText: 'Password',
                prifixIcon: const Icon(
                  Icons.password,
                  color: CustomColors.thirdColor,
                ),
                surfixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObsecure = !_isObsecure;
                    });
                  },
                  icon: _isObsecure
                      ? const Icon(
                          Icons.visibility,
                          color: CustomColors.thirdColor,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: CustomColors.thirdColor,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            MyButton(
              onTap: signIn,
              btn_txt: 'LogIn',
              back_btn: CustomColors.thirdColor,
              marginSize: w / 3,
            ),
            const SizedBox(height: 10),
            // Loading spinner
            if (_isLoading)
              SpinKitCircle(
                color: CustomColors.thirdColor,
                size: w / 7,
              ),
          ],
        ));
  }

  void signIn() async {
    setState(() {
      _isLoading = true; // Show the loading spinner
    });
    // assign value to email and password from controllers
    email = _emailController.text;
    password = _passwordController.text;
    //check the validity of email and password if it is null
    if (email.isEmpty || email == null) {
      showSnackBar(context, 'Please enter email');
      setState(() {
        _isLoading = false; // hide the loading spinner
      });
      return;
    } else if (password.isEmpty || password == null) {
      showSnackBar(context, 'Please enter password');
      setState(() {
        _isLoading = false; // hide the loading spinner
      });
      return;
    } else {
      try {
        // if all catch errors fix will login to student home page and loin user to firebase auth.
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        getUserDetails(context);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          // if email not match all to user email it will return user not found
          showSnackBar(context, 'E-mail or password are incorrect');
          return;
        } else if (e.code == 'invalid-email') {
          // if user insert in valid email it will return invalid email
          showSnackBar(context, 'The email address is not valid.');
          return;
        } else if (e.code == 'network-request-failed') {
          showSnackBar(context,
              'A network error occurred. Please check your internet connection.');
          return;
        }
      } finally {
        setState(() {
          _isLoading = false; // hide the loading spinner
        });
      }
    }
  }
  void getUserDetails(BuildContext context){
    // get user uid from firebase auth
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child('users').child(uid);
      // retrieve data from user node uid child and store in to map
      userRef.onValue.listen((event) async {
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.value != null) {
          Map<dynamic, dynamic> userData = Map<dynamic, dynamic>.from(
              snapshot.value as Map<dynamic, dynamic>);


          // if you want to get value in string you can use this
          //String name = userData['name'];


          // saving user data to shared prefenace
          SharedPref sharedPref = SharedPref();
          sharedPref.saveUserData(
            email: userData['email'],
            password: userData['password'],
            name: userData['name'],
            grade: userData['grade'],
            type: userData['type'],
            phone: userData['phone'],
            uid: userData['uid'],
          );
          // go to Home page
          if(userData['type'] == 'Student'){
            // user type == student go to Student page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(),
              ),
            );
            return;
          } else if(userData['type'] == 'Admin'){
            // user type == admin go to administration page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(),
              ),
            );
            return;
          }else {
            // user type == teacher or homeroom go to teachers page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(),
              ),
            );
            return;
          }


        }
      }, onError: (error) {
        showSnackBar(context, error.toString());
      });
    } else {
      showSnackBar(context, 'No user found');
    }
  }
}
