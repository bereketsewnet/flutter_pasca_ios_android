import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pasca/wediget/user_list_view.dart';

class UsersListPage extends StatefulWidget {
  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("users");

  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic>? values = snapshot.data?.snapshot.value as Map?;
            values?.forEach((key, values) {
              lists.add(values);
            });
            return ListView.builder(
              shrinkWrap: true,
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return UsersListView(
                  lists[index]["imageUrl"],
                  lists[index]["name"],
                  lists[index]["message"],
                  lists[index]["timeStamp"],
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
// FutureBuilder<DatabaseEvent>(
// future: someFutureThatReturnsDatabaseEvent,
// builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
// // Your builder logic here
// },
// )
