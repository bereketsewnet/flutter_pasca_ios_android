import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/bottom_navigation.dart';
import 'package:pasca/wediget/snack_bar.dart';
import 'package:pasca/wediget/normal_button.dart';
import 'package:pasca/wediget/normal_textfield.dart';
import 'package:firebase_database/firebase_database.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool _isObsecure = true;

// create variable and list for user-type drop-down menu
  String? valueChooseType;
  List listItemType = ['Student', 'Teacher', 'HomeRoom', 'Admin'];

  // create variable and list for class drop-down menu
  String? valueChooseClass;
  List listItemClass = [
    'Staff',
    'Nursery',
    'kg-1',
    'kg-2',
    'kg-3',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8'
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    gradeController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Let\'s create an account',
                  style: TextStyle(
                    color: CustomColors.thirdColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: EdgeInsets.only(left: 15),
                    height: 45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: CustomColors.fourthColor, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      dropdownColor: CustomColors.primaryColor,
                      icon: const Icon(
                        Icons.arrow_circle_down,
                        color: CustomColors.thirdColor,
                      ),
                      style: const TextStyle(color: CustomColors.thirdColor),
                      iconSize: 20,
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text(
                        'Class',
                        style: TextStyle(
                          color: CustomColors.thirdColor,
                        ),
                      ),
                      value: valueChooseClass,
                      onChanged: (newValue) {
                        setState(() {
                          valueChooseClass = newValue as String?;
                        });
                      },
                      items: listItemClass.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: EdgeInsets.only(right: 15),
                    height: 45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: CustomColors.fourthColor, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      dropdownColor: CustomColors.primaryColor,
                      icon: Icon(
                        Icons.arrow_circle_down,
                        color: CustomColors.thirdColor,
                      ),
                      style: TextStyle(color: CustomColors.thirdColor),
                      iconSize: 20,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text(
                        'User Type',
                        style: TextStyle(
                          color: CustomColors.thirdColor,
                        ),
                      ),
                      value: valueChooseType,
                      onChanged: (newValue) {
                        setState(() {
                          valueChooseType = newValue as String?;
                        });
                      },
                      items: listItemType.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              margin: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: MyTextField(
                controller: nameController,
                keybordType: TextInputType.name,
                obscureText: false,
                lableText: 'Full Name',
                prifixIcon: const Icon(
                  Icons.person,
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
                controller: emailController,
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
                controller: phoneController,
                keybordType: TextInputType.phone,
                obscureText: false,
                lableText: 'Phone',
                prifixIcon: const Icon(
                  Icons.phone,
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
                controller: passwordController,
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
              onTap: Register,
              btn_txt: 'Create Account',
              back_btn: CustomColors.thirdColor,
              marginSize: 20,
            ),
            const SizedBox(height: 10),
            if (isLoading)
              SpinKitCircle(
                color: CustomColors.thirdColor,
                size: w / 8,
              ),
          ],
        ),
      ),
    );
  }

  void Register() async {
    setState(() {
      isLoading = true; // show loading
    });
    // check if user type and class not null and hide loading page
    if (valueChooseClass == null) {
      showSnackBar(context, 'Please enter class');
      setState(() {
        isLoading = false; // hide loading
      });
      return;
    }

    if (valueChooseType == null) {
      showSnackBar(context, 'Please enter user-type');
      setState(() {
        isLoading = false; // hide loading
      });
      return;
    }
    // create and cast string value
    String email, password, name, grade, type, phone, uid;

    email = emailController.text;
    password = passwordController.text;
    name = nameController.text;
    grade = valueChooseClass!;
    type = valueChooseType!;
    phone = phoneController.text;

    if (password != null) {
      try {
        if (name.isEmpty ||
            email.isEmpty ||
            phone.isEmpty ||
            password.isEmpty) {
          showSnackBar(context, 'All filed are required!');
          setState(() {
            isLoading = false; // hide loading
          });
          return;
        } else if (phone.length != 10) {
          showSnackBar(context, 'PhoneNumber must be 10 char');
          setState(() {
            isLoading = false; // hide loading
          });
          return;
        } else if (name.length < 5) {
          showSnackBar(context, 'Please insert properly full name');
          setState(() {
            isLoading = false; // hide loading
          });
          return;
        } else {
          // if all try-catch errors are not found, then register user in to realtime database and auth

          // register user in to auth
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: password);
          User? user = FirebaseAuth.instance.currentUser;
          uid = user!.uid;

          // register user in to realtime database
          DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

          // locate reference point that user node inserted
          DatabaseReference usersRef = databaseRef.child('users').child(uid);

          // Define the data to be inserted
          Map<String, dynamic> userData = {
            'name': name,
            'email': email,
            'phone': phone,
            'password': password,
            'grade': grade,
            'type': type,
            'uid': uid,
            'profilePic': 'https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg',
          };

          // Insert the data at the generated reference
          usersRef.set(userData).then((_) {
            // after registration clean all
            nameController.text = '';
            emailController.text = '';
            phoneController.text = '';
            phoneController.text = '';
            passwordController.text = '';
            showSnackBar(context, 'Success');
          }).catchError((error) {
            showSnackBar(context, error.toString());
          });
        }
      } on FirebaseAuthException catch (e) {
        // checking the validity of user inserted data
        if (e.code == 'weak-password') {
          showSnackBar(context, "Password provided is too weak.");
          return;
        } else if (e.code == 'email-already-in-use.') {
          showSnackBar(context, 'Account already exists.');
          return;
        } else if (e.code == 'invalid-email') {
          showSnackBar(context, 'The email address is not valid.');
          return;
        } else if (e.code == 'network-request-failed') {
          showSnackBar(context,
              'A network error occurred. Please check your internet connection.');
          return;
        }
      } finally {
        setState(() {
          isLoading = false; // hide loading
        });
      }
    }
  }
}
