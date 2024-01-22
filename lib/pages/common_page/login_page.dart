import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasca/pages/student_page/student_home_page.dart';
import 'package:pasca/wediget/snack_bar.dart';

import '../../assets/custom_colors/colors.dart';
import '../../wediget/normal_button.dart';
import '../../wediget/normal_textfield.dart';

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
                obscureText: true,
                lableText: 'Password',
                prifixIcon: const Icon(
                  Icons.password,
                  color: CustomColors.thirdColor,
                ),
                surfixIcon: const Icon(
                  Icons.visibility_off_sharp,
                  color: CustomColors.thirdColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            MyButton(
              onTap: LogIn,
              btn_txt: 'LogIn',
              back_btn: CustomColors.thirdColor,
              marginSize: w / 3,
            ),
          ],
        ));
  }

  void LogIn() async {
    // assign value to email and password from controllers
    email = _emailController.text;
    password = _passwordController.text;
    //check the validity of email and password if it is null
    if (email.isEmpty || email == null) {
      showSnackBar(context, 'Please enter email');
    } else if (password.isEmpty || password == null) {
      showSnackBar(context, 'Please enter password');
    } else {
      try {
        // if all catch errors fix will login to student home page and loin user to firebase auth.
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentHomePage(),
          ),
        );
      } on FirebaseAuthException catch (e) {

        if (e.code == 'invalid-credential') {
          // if email not match all to user email it will return user not found
          showSnackBar(context, 'E-mail or password are incorrect');
        } else if (e.code == 'invalid-email') {
          // if user insert in valid email it will return invalid email
          showSnackBar(context, 'The email address is not valid.');
        } else if (e.code == 'network-request-failed') {
          showSnackBar(context,
              'A network error occurred. Please check your internet connection.');
        }
      }
    }
  }
}
