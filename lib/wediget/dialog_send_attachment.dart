import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

import '../firebase_service/storage/upload_image.dart';
import '../firebase_service/storage/upload_pdf.dart';
import 'attachmet_options_model.dart';

void showAttachmentOptions(BuildContext context, String uid, String friendId) {
  showModalBottomSheet(
    context: context,
    elevation: 0,
    backgroundColor: CustomColors.secondaryColor,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: Cross,
          children: [
            Attachment_options(
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: CustomColors.thirdColor,
                size: 24,
              ),
              description: 'Camera',
              onPressed: () {
                insetImageCameraForChat(context, uid, friendId);
                Navigator.pop(context);
              },
            ),
            Attachment_options(
              icon: const Icon(
                Icons.insert_photo_rounded,
                color: CustomColors.thirdColor,
                size: 28,
              ),
              description: 'Gallery',
              onPressed: () {
                insetImageGalleryForChat(context, uid, friendId);
                Navigator.pop(context);
              },
            ),
            Attachment_options(
              icon: const Icon(
                Icons.file_upload_rounded,
                color: CustomColors.thirdColor,
                size: 28,
              ),
              description: 'Document',
                onPressed: () {
                  pickPdfFile(context);
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      );
    },
  );
}
