import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/favorite/db_provider.dart';
import '../home/story_item_card_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<DbProvider>(context, listen: false);
      provider.loadAllRestaurant();
      //context.read<DbProvider>().loadAllRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite List"),
      ),
      body: Consumer<DbProvider>(
        builder: (_, value, __) {
          final restaurantList = value.restaurantList ?? [];
          if (kDebugMode) {
            print("Get Data DB Local: $restaurantList");
          }
          return switch (restaurantList.isNotEmpty) {
            true => ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (_, index) {
                  final restaurant = restaurantList[index];
                  return StoryItemCardWidget(
                    story: restaurant,
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Favorite"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
