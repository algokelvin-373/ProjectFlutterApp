import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant.dart';
import '../../data/model/restaurant_detail.dart';
import '../../provider/detail/favorite_icon_provider.dart';
import '../../provider/favorite/db_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;

  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();
    final dbProvider = context.read<DbProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await dbProvider.loadRestaurantById(widget.restaurant.id);
      final value = dbProvider.restaurant == null
          ? false : dbProvider.restaurant!.id == widget.restaurant.id;
      favoriteIconProvider.isFavorite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final dbProvider = context.read<DbProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorite = favoriteIconProvider.isFavorite;

        if (isFavorite) {
          await dbProvider.removeRestaurantById(widget.restaurant.id);
          favoriteIconProvider.isFavorite = false;
        } else {
          final data = Restaurant(
              id: widget.restaurant.id,
              name: widget.restaurant.name,
              description: widget.restaurant.description,
              pictureId: widget.restaurant.pictureId,
              city: widget.restaurant.city,
              rating: widget.restaurant.rating,
          );
          await dbProvider.saveRestaurant(data);
          favoriteIconProvider.isFavorite = true;
        }
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>()
            .isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}