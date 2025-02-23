import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/base/home/home_tab.dart';
import 'package:mobile_flutter/base/user/user_tab.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reqres App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeAppPage(),
    );
  }
}

class HomeAppPage extends StatefulWidget {
  const HomeAppPage({super.key});

  @override
  State<HomeAppPage> createState() => _HomeAppPage();
}

class _HomeAppPage extends State<HomeAppPage> {
  int _selectedIndex = 0;

  static const List<Widget> __pages = <Widget>[
    HomeTab(),
    UserTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_selectedIndex == 0 ? 'Home' : 'User'),
      ),
      body: __pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
