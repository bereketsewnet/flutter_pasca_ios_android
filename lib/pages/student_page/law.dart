import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Law extends StatelessWidget {
  const Law({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: const Text(
        'Law',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
