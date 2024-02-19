import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BooksCollectionsEachView extends StatefulWidget {
  BooksCollectionsEachView(
      {Key? key, required this.bookName, required this.bookUrl})
      : super(key: key);
  String bookName;
  String bookUrl;

  @override
  State<BooksCollectionsEachView> createState() =>
      _BooksCollectionsEachViewState();
}

class _BooksCollectionsEachViewState extends State<BooksCollectionsEachView> {
  PDFDocument? document;

  void downloadPDF() async {
    document = await PDFDocument.fromURL(widget.bookUrl);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.thirdColor,
          ),
        ),
        title: Text(
          widget.bookName,
          style: const TextStyle(color: CustomColors.thirdColor),
        ),
      ),
      body: SafeArea(
        child: SfPdfViewer.network(widget.bookUrl),
      ),
    );
  }
}
