import 'package:flutter/material.dart';

class HomeWidget {
  Widget listAbsenWidget(List<String> absenList) {
    return Expanded(
      child: ListView.builder(
        itemCount: absenList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(absenList[index]),
          );
        },
      ),
    );
  }
}
