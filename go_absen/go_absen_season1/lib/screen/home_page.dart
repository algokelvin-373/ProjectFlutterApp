import 'package:flutter/material.dart';
import 'package:go_absen_season1/widget/home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoAbsen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePageState(),
    );
  }
}

class HomePageState extends StatefulWidget {
  const HomePageState({super.key});

  @override
  State<HomePageState> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  final homeWidget = HomeWidget();
  final TextEditingController _nameController = TextEditingController();
  final List<String> _absenList = [];

  void _addAbsen() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        _absenList.add(name);
        _nameController.clear();
      });
    }
  }

  Widget _mainPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Icon(Icons.account_circle, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text('Masukkan Nama untuk Absen:', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _addAbsen, child: Text('Absen')),
          SizedBox(height: 20),
          homeWidget.listAbsenWidget(_absenList),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GoAbsen')),
      body: _mainPage(context),
    );
  }
}
