import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/wediget/snack_bar.dart';
class FetchDataFirebase extends StatefulWidget {
  const FetchDataFirebase({Key? key}) : super(key: key);

  @override
  State<FetchDataFirebase> createState() => _FetchDataFirebaseState();
}

class _FetchDataFirebaseState extends State<FetchDataFirebase> {

  @override
  void initState() {
    super.initState();
    listenToUserData();
  }


  StreamController<List<Map<String, dynamic>>> _controller =
  StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get userDataStream => _controller.stream;

  void listenToUserData() {
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child("users");

    databaseReference.onChildAdded.listen((event) {
      String? uid = event.snapshot.key;
      Map userData = event.snapshot.value as Map;

      // Here, 'uid' is the user's unique identifier, and 'userData' is the user's data
      //print("UID: $uid, UserData: $userData");
      userData.forEach((key, value) {
        if(userData['name'] == 'amaru'){
          print("UID: $uid, UserData: $userData['name']");
        }
      });

      // Add your logic to process the user data as needed
    });

    // databaseReference.onChildChanged.listen((event) {
    //   String? uid = event.snapshot.key;
    //   Map updatedData = event.snapshot.value as Map;
    //
    //   // Here, 'uid' is the user's unique identifier, and 'updatedData' is the updated user data
    //   print("UID: $uid, UpdatedData: $updatedData");
    //
    //   // Add your logic to handle the updated user data
    // });
    //
    // // You can also handle onChildRemoved if needed
    // databaseReference.onChildRemoved.listen((event) {
    //   String? uid = event.snapshot.key;
    //
    //   // Here, 'uid' is the user's unique identifier
    //   print("UID: $uid removed");
    //
    //   // Add your logic to handle the removed user
    // });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> chats = snapshot.data!;


            // Display the fetched data in your UI, e.g., using a ListView
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chats[index]['message']),
                  // Add other fields as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
