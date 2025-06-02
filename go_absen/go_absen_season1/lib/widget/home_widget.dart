import 'package:flutter/material.dart';

class HomeWidget {
  Widget itemListVerticalWidget(String data) {
    return Row(
      children: [
        Icon(Icons.account_circle, size: 50, color: Colors.blue),
        SizedBox(width: 5),
        Text(data, style: TextStyle(fontSize: 20.0, color: Colors.black)),
      ],
    );
  }

  Widget itemListHorizontalWidget(String data) {
    return Column(
      children: [
        Icon(Icons.account_circle, size: 50, color: Colors.blue),
        SizedBox(width: 5),
        Text(data, style: TextStyle(fontSize: 20.0, color: Colors.black)),
      ],
    );
  }

  Widget listVerticalWidget(List<String> absenList) {
    return ListView.builder(
      itemCount: absenList.length,
      itemBuilder: (context, index) {
        return itemListVerticalWidget(absenList[index]);
      },
    );
  }

  Widget listHorizontalWidget(List<String> absenList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: absenList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: itemListHorizontalWidget(absenList[index]),
        );
      },
    );
  }

  Widget listAbsenWidget(List<String> absenList, String listType) {
    return Expanded(
      child:
          listType == 'horizontal'
              ? listHorizontalWidget(absenList)
              : listVerticalWidget(absenList),
    );
  }
}
