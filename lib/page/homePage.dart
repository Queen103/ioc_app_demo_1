// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable, library_private_types_in_public_api, no_logic_in_create_state, unused_field, unused_import

import 'package:ioc_app_demo_1/page/testPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _page = [const Page1(), const Page2(), const Page3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.family_restroom_outlined),
            label: 'Family',
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