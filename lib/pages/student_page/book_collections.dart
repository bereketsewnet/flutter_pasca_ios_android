import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksCollections extends StatefulWidget {
  BooksCollections({Key? key, this.bookName, required this.bookUrl})
      : super(key: key);
  String? bookName;
  String bookUrl;

  @override
  State<BooksCollections> createState() => _BooksCollectionsState();
}

class _BooksCollectionsState extends State<BooksCollections> {
  PDFDocument? document;

  void downloadPDF() async {
    document = await PDFDocument.fromURL(widget.bookUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(
              document: document!,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
