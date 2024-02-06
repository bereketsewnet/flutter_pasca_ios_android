import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:pasca/permission/android/camera_and_gallary_permission.dart';
import 'package:pasca/wediget/custom_button.dart';
import 'package:pasca/wediget/normal_button.dart';
import 'package:pasca/wediget/snack_bar.dart';

class UploadIamge extends StatefulWidget {
  const UploadIamge({Key? key}) : super(key: key);

  @override
  State<UploadIamge> createState() => _UploadIamgeState();
}
class _UploadIamgeState extends State<UploadIamge> {
  @override
  void initState() {
    super.initState();
    checkPermissions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: AppBar(
        title: const Text('ImageUpload'),
        elevation: 0,
        backgroundColor: CustomColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt,
              color: CustomColors.thirdColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: insetImageGallery,
            icon: const Icon(
              Icons.photo_library_sharp,
              color: CustomColors.thirdColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 30),
          MyButton(
            onTap: () {},
            btn_txt: 'Insert',
            marginSize: 50,
            back_btn: CustomColors.thirdColor,
          )
        ],
      ),
    );
  }
  Future<void> insetImageGallery() async{
    Reference sRef = FirebaseStorage.instance.ref().child('ProfilePicture');
    ImagePicker imagePicker = ImagePicker();
    String imageUrl;
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    try{
      await sRef.child(imageName).putFile(
        File(file!.path),
        SettableMetadata(contentType: 'image/jpeg'), // Set the appropriate content type
      );
      imageUrl = await sRef.child(imageName).getDownloadURL();
      showSnackBar(context, imageUrl);
    }catch(error){
      showSnackBar(context, error.toString());
    }

  }
}
