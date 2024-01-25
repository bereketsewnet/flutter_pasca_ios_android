import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pasca/wediget/user_list_view.dart';

class CodeTest extends StatefulWidget {
  const CodeTest({Key? key}) : super(key: key);

  @override
  State<CodeTest> createState() => _CodeTestState();
}

class _CodeTestState extends State<CodeTest> {
  Query dbRef = FirebaseDatabase.instance.ref().child('users');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('new data'),
        ),
        body: Container(
          child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map users = snapshot.value as Map;
                users['key'] = snapshot.key;

                return UsersListView(users: users);
              }),
        ),
      ),
    );
  }
}
