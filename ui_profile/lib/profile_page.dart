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
  // Create Method Widget Page
  Widget _mainPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/img_posting.png',
          width: 300,
          height: 300,
        ),
        const SizedBox(height: 8),
        Text(
          'ALGOKELVIN',
          style: TextStyle(
            fontSize: 24,
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter Developer - UI Widget',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _mainPage(context),
        ),
      ),
    );
  }
}
