import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello'),),
      body: Text('Calendar', style: TextStyle(color: Colors.black),),
    );
  }
}
