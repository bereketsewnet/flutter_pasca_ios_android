import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: SfPdfViewer.network(widget.bookUrl),
      ),
    );
  }
}
