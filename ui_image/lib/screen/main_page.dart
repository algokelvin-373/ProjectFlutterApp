import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MainPageState(title: 'Flutter Training - Image'),
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
  var pathImage = 'assets/images/sample_image.JPG';

  Widget _mainPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image Original with Size 200 x 200
          Image.asset(
            pathImage,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ), // Image Original
          SizedBox(height: 5),
          // Implement Image with ClipOval
          ClipOval(
            child: Image.asset(
              pathImage,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ), // Implement Image with ClipOval
          SizedBox(height: 5),
          // Implement Image with ClipOval
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              pathImage,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ), // Implement Image with ClipRect
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _mainPage(context),
    );
  }
}
