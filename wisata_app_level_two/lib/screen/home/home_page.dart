import 'package:flutter/material.dart';
import 'package:wisata_app_level_two/static/navigation_route.dart';
import 'package:wisata_app_level_two/utils/global_data.dart';

import 'tourism_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      body: ListView.builder(
        itemCount: tourismList.length,
        itemBuilder: (context, index) {
          final tourism = tourismList[index];

          return TourismCard(
            tourism: tourism,
            onTap: () {
              // todo-05: navigate to detail screen
              Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: tourism,
              );
            },
          );
        },
      ),
    );
  }
}