import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/wediget/book_collections_list_view_model.dart';
import 'package:pasca/wediget/snack_bar.dart';

class StudentBookCollection extends StatefulWidget {
  const StudentBookCollection({super.key});

  @override
  State<StudentBookCollection> createState() => _StudentBookCollectionState();
}

class _StudentBookCollectionState extends State<StudentBookCollection> {
  List<Map<dynamic, dynamic>> result = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    result = await getStudentBookCollection();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bereket sewnet'),
      ),
      body: result.isNotEmpty
          ? ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                Map<dynamic, dynamic> resultMap = result[index];
                return BookCollectionModule(resultMap);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<List<Map<dynamic, dynamic>>> getStudentBookCollection() async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();
    List<Map<dynamic, dynamic>> bookDetailList = [];
    // Reference storageRef = FirebaseStorage.instance.ref().child('BookCollections');

    await dbRef.child('BooksCollections').once().then((value) {
      Map<dynamic, dynamic> bookDetail =
          value.snapshot.value as Map<dynamic, dynamic>;
      bookDetail.forEach((key, value) {
        bookDetailList.add(Map<dynamic, dynamic>.from(value));
        print(value['bookUrl']);
      });
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString());
    });
    return bookDetailList;
  }
}
