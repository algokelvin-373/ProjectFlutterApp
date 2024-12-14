import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/screen/profile/profile_screen.dart';

import '../../provider/main/index_nav_provider.dart';
import '../home/home_screen.dart';

class MainScreen extends StatelessWidget {
  final Function(String) onTapped;
  final Function() onLogout;

  const MainScreen({
    super.key,
    required this.onTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => HomeScreen(onTapped: onTapped),
            _ => ProfileUserScreen(onLogout: onLogout),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            tooltip: "Profile",
          ),
        ],
      ),
    );
  }
}
