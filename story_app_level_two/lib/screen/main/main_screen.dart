import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/screen/profile/profile_screen.dart';

import '../../provider/main/index_nav_provider.dart';
import '../home/home_screen.dart';

class MainScreen extends StatelessWidget {
  final Function(String) onTapped;
  final Function() onPostStory;
  final Function() onLogout;
  final Function() onRefreshHomeScreen;

  const MainScreen({
    super.key,
    required this.onTapped,
    required this.onPostStory,
    required this.onLogout,
    required this.onRefreshHomeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => HomeScreen(
              onTapped: onTapped,
              onPostStory: onPostStory,
              onRefreshHomeScreen: onRefreshHomeScreen,
            ),
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
