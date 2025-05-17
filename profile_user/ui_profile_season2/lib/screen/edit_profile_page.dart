import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final List<Map<String, dynamic>> infoList;

  const EditProfilePage({
    Key? key,
    required this.infoList,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = widget.infoList
        .map((item) => TextEditingController(text: item['value']))
        .toList();
  }

  void _saveProfile() {
    List<Map<String, dynamic>> updatedList = [];
    for (int i = 0; i < widget.infoList.length; i++) {
      updatedList.add({
        'icon': widget.infoList[i]['icon'],
        'label': widget.infoList[i]['label'],
        'value': _controllers[i].text,
      });
    }
    Navigator.pop(context, updatedList);
  }

  AppBar _header() {
    return AppBar(
      title: const Text(
        'Edit Profile Info',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
    );
  }

  Widget _mainPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage('assets/images/ic_logo.png'),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text("Change Profile Picture"),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < widget.infoList.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _controllers[i],
                decoration: InputDecoration(
                  labelText: widget.infoList[i]['label'],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: widget.infoList[i]['label'] == 'Location'
                      ? 'Ex: San Francisco, CA'
                      : null,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
