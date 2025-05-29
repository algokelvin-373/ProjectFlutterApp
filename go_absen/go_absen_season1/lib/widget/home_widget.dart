import 'package:flutter/material.dart';

class HomeWidget {
  Widget itemListWidget(String data) {
    return Row(
      children: [
        Icon(Icons.account_circle, size: 50, color: Colors.blue),
        SizedBox(width: 5),
        Text(data, style: TextStyle(fontSize: 20.0, color: Colors.black)),
      ],
    );
  }

  Widget listAbsenWidget(List<String> absenList) {
    return Expanded(
      child: ListView.builder(
        itemCount: absenList.length,
        itemBuilder: (context, index) {
          return itemListWidget(absenList[index]);
        },
      ),
    );
  }
}
