import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MainPageState(title: 'Onboarding'),
    );
  }
}

class MainPageState extends StatefulWidget {
  const MainPageState({super.key, required this.title});

  final String title;

  @override
  State<MainPageState> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageState> {
  Widget _mainPage(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Image.asset('assets/images/my_profile.png', height: 220),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Enjoy fast, reliable delivery\nstraight to your doorstep',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Online reservation and home delivery system for restaurants and cafes.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          const Spacer(flex: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Arahkan ke halaman berikutnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Get Started', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _mainPage(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
