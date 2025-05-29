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

  String _currentListType = 'vertical';

  void _addAbsen() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        _absenList.add(name);
        _nameController.clear();
      });
    }
  }

  AppBar _header() {
    return AppBar(
      title: const Text('GoAbsen'),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu), // Hamburger menu icon
          onPressed: () {
            _showMenuTypeItem(context);
          },
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  void _showMenuTypeItem(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Tipe List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentListType = 'vertical';
                      });
                      Navigator.pop(context);
                    },
                    child: _menuItem(Icons.view_list, 'List Vertikal'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentListType = 'horizontal';
                      });
                      Navigator.pop(context);
                    },
                    child: _menuItem(Icons.view_carousel, 'List Horizontal'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
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
          homeWidget.listAbsenWidget(_absenList, _currentListType),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _header(), body: _mainPage(context));
  }
}
