import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello'),),
      body: Text('Library', style: TextStyle(color: Colors.black),),
    );
  }
}
