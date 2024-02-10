import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
import 'dart:io';

import '../../wediget/snack_bar.dart';

Future<void> insetImageGalleryForProfile(
    BuildContext context, String uid) async {
  // storage reference
  Reference sRef = FirebaseStorage.instance.ref().child('ProfilePicture');
  // real time database reference
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  ImagePicker imagePicker = ImagePicker();

  String imageUrl;

  // set image name by their uploaded time by second
  String imageName = DateTime.now().millisecondsSinceEpoch.toString();

  // store getfrom image to gallery to file datatype
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  try {
    await sRef.child(imageName).putFile(
          // put file in to base on reference and change the form in to image/jpeg.
          File(file!.path),
          SettableMetadata(
              contentType: 'image/jpeg'), // Set the appropriate content type
        );

    // store image address in to image url to string
    imageUrl = await sRef.child(imageName).getDownloadURL();

    // store imageUrl in to user info list and update the default profile pic
    await dbRef.child('users').child(uid).update({'profilePic': imageUrl});
    SharedPref().setProfilePic(imageUrl);
    showSnackBar(context, 'Completed');
  } catch (error) {
    showSnackBar(context, error.toString());
  }
}

// to upload image by two people chatroom
Future<void> insetImageGalleryForChat(
    BuildContext context, String uid, String friendId) async {
  // storage reference
  Reference sRef = FirebaseStorage.instance.ref().child('ChatPicture');
  // real time database reference
  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('Chats').push();
  String? messageKey = dbRef.key;
  ImagePicker imagePicker = ImagePicker();

  String imageUrl;

  // set image name by their uploaded time by second
  String imageName = DateTime.now().millisecondsSinceEpoch.toString();

  // store getfrom image to gallery to file datatype
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  try {
    await sRef.child(imageName).putFile(
          // put file in to base on reference and change the form in to image/jpeg.
          File(file!.path),
          SettableMetadata(
              contentType: 'image/jpeg',), // Set the appropriate content type
        );

    // store image address in to image url to string
    imageUrl = await sRef.child(imageName).getDownloadURL();

    Map<String, dynamic> chatData = {
      'message': imageUrl,
      'sender': uid,
      'isSeen': false,
      'receiver': friendId,
      'timeStamp': ServerValue.timestamp,
      'refkey': messageKey,
      'messageType' : 'Image',
    };
    await dbRef.set(chatData).then((_) {
      // handle code when data inserted
      showSnackBar(context, 'completed');
    });
  } catch (error) {
    showSnackBar(context, error.toString());
  }
}
