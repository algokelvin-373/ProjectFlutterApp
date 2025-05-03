import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Create Method Widget Page
  // ignore: non_constant_identifier_names
  Widget _main_page(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('AlgoKelvin clicked!')),
            );
          },
          child: Image.asset(
            'assets/images/ic_fresh_shop.png',
            width: 200,
            height: 200,
          ),
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
          child: _main_page(context),
        ),
      ),
    );
  }
}
