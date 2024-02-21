import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:pasca/wediget/snack_bar.dart';

Future<void> uploadPdf(String fileName, File file, BuildContext context) async {
  try {
    final Reference reference =
    FirebaseStorage.instance.ref().child('BooksCollections/$fileName.pdf');
    final dbRef = FirebaseDatabase.instance.ref().child('BooksCollections');

    await reference.putFile(file);
    final String downloadLink = await reference.getDownloadURL();
    dbRef.push().set({
      'bookName' : fileName,
      'bookUrl'  : downloadLink,
    }).then((_) {
      showSnackBar(context, 'completed');
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString());
    });
  } catch (e) {
    // Handle any errors that might occur during the upload.
  String  error = e.toString();
    showSnackBar(context,"Error uploading PDF: $error");

  }
}


void pickPdfFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    String fileName = result.files.single.name;
    File file = File(result.files.single.path!);
    uploadPdf(fileName, file, context);
  } else {
    // User canceled the picker
    showSnackBar(context, 'Please insert pdf file');
  }
}


