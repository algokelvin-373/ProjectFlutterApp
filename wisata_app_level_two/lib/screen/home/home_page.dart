import 'package:flutter/material.dart';
import 'package:wisata_app_level_two/utils/global_data.dart';

import '../../static/navigation_route.dart';
import 'tourism_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tourism List"),
        ),
        body: ListView.builder(
          itemCount: tourismList.length,
          itemBuilder: (context, index) {
            final tourism = tourismList[index];
            return TourismCardWidget(
              tourism: tourism,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NavigationRoute.detailRoute.name,
                  arguments: tourism,
                );
              },
            );
          },
        ),
      ),
    );
  }
}