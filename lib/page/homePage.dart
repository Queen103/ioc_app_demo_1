// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable, library_private_types_in_public_api, no_logic_in_create_state, unused_field, unused_import

import 'package:ioc_app_demo_1/page/historyPage.dart';
import 'package:ioc_app_demo_1/page/requirementPage.dart';
import 'package:ioc_app_demo_1/page/testPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ioc_app_demo_1/page/userProfilePage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _page = [
    RequirementPage(),
    HistoryPage(),
    UserProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait_sharp),
            label: 'Porfile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
