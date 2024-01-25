import 'package:flutter/material.dart';


class ThirdCodeTest extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Private'),
    const Tab(text: 'Public'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar Example'),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Person Tab'),
            ),
            Center(
              child: Text('Group Tab'),
            ),
          ],
        ),
      ),
    );
  }
}