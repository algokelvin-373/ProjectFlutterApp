import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: const ProfilePageState(
        title: 'Profile Page',
      ),
    );
  }
}

class ProfilePageState extends StatefulWidget {
  const ProfilePageState({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ProfilePageState> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageState> {
  static const URL_Image =
      'https://github.com/algokelvin-373/algokelvin-373.github.io/blob/master/img/ic_logo_algokelvin.png';

  // Create Header
  AppBar _header() {
    return AppBar(
      title: const Text(
        'My Profile',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.black),
          onPressed: () {
            print('Click Action');
          },
        ),
      ],
    );
  }

  // Create Method Widget Page
  Widget _mainPage(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(URL_Image),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ALGOKELVIN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '@algokelvin',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
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
