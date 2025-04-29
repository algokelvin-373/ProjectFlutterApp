import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('FreshShop clicked!')),
                  );
                },
                child: Image.asset(
                  'assets/images/ic_fresh_shop.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'FRESHOP',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Discover Grocery and Food',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'If you eat fresh foods that have a living energy, '
                  'the food returns that living energy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
