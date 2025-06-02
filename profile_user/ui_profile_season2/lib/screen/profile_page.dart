import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_profile_season2/data/profile_data.dart';
import 'package:ui_profile_season2/screen/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ProfilePageState(title: 'Profile Page'),
    );
  }
}

class ProfilePageState extends StatefulWidget {
  const ProfilePageState({super.key, required this.title});

  final String title;

  @override
  State<ProfilePageState> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageState> {
  var _infoProfile = ProfileData().infoList;

  // Create Header
  AppBar _header() {
    return AppBar(
      title: const Text('My Profile', style: TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          SystemNavigator.pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.black),
          onPressed: () async {
            final updatedList = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(infoList: _infoProfile),
              ),
            );
            if (updatedList != null) {
              setState(() {
                _infoProfile = List<Map<String, dynamic>>.from(updatedList);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _profileHeader() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage('assets/images/ic_logo.png'),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('@username', style: TextStyle(color: Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _personalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          _infoProfile.map((item) {
            return _infoItem(item['icon'], item['label'], item['value']);
          }).toList(),
    );
  }

  // Widget Main Page
  Widget _mainPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileHeader(),
          const SizedBox(height: 20),
          _personalInfo(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _mainPage(context),
        ),
      ),
    );
  }
}
