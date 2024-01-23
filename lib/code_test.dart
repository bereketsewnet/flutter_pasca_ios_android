import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


void getUserDetails() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String uid = user.uid;
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(uid);

    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Map<dynamic, dynamic> userData = Map<dynamic, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        String name = userData['name'];
        String email = userData['email'];
        print('User Name: $name');
        print('User Email: $email');
        // showSnackBar(context as BuildContext, name);
        // showSnackBar(context as BuildContext, email);
      }
    } as FutureOr Function(DatabaseEvent value)).catchError((error) {
      print('Error retrieving user details: $error');
    });
  }
}
