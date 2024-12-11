import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant_detail.dart';
import '../../provider/detail/favorite_icon_provider.dart';
import '../../provider/detail/restaurant_detail_provider.dart';
import '../../static/restaurant_detail_result.dart';
import '../../utils/global_function.dart';
import 'build_size_chip.dart';
import 'favorite_icon_widget.dart';
import 'icon_text.dart';
import 'restaurant_add_review_widget.dart';
import 'restaurant_menus_widget.dart';
import 'restaurant_reviews_widget.dart';

class RestaurantDataWidget extends StatefulWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantDataWidget({super.key, required this.restaurantDetail});

  @override
  State<RestaurantDataWidget> createState() => _RestaurantDataWidgetState();
}

class _RestaurantDataWidgetState extends State<RestaurantDataWidget> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> listCategoriesWidget = widget.restaurantDetail.categories
        .map((category) => buildSizeChip(category.name))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.restaurantDetail.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => FavoriteIconProvider(),
              child: Consumer<RestaurantDetailProvider>(
                builder: (_, value, __) {
                  return switch (value.resultState) {
                    RestaurantDetailLoadedState(data: var restaurant) =>
                      FavoriteIconWidget(restaurant: restaurant),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
        spaceVertical(10),
        Text(
          widget.restaurantDetail.address,
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 14
          ),
        ),
        spaceVertical(15),
        Wrap(
          spacing: 4, // Horizontal spacing between chips
          runSpacing: 4, // Vertical spacing if they wrap to the next line
          alignment: WrapAlignment.start, // Align to the start
          children: listCategoriesWidget,
        ),
        spaceVertical(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconText(
                icon: Icons.star,
                label: widget.restaurantDetail.rating.toString()
            ),
            IconText(
                icon: Icons.location_city,
                label: widget.restaurantDetail.city
            ),
          ],
        ),
        spaceVertical(20),
        Text(
          widget.restaurantDetail.description,
          style: const TextStyle(
              fontSize: 14,
          ),
        ),
        spaceVertical(15),
        textCenter('Menu Food and Drink'),
        lines(),
        RestaurantMenusWidget(restaurantDetail: widget.restaurantDetail),
        spaceVertical(15),
        textCenter('Reviews'),
        lines(),
        RestaurantReviewsWidget(restaurantDetail: widget.restaurantDetail),
        spaceVertical(15),
        RestaurantAddReviewWidget(restaurantId: widget.restaurantDetail.id),
      ],
    );
  }
}