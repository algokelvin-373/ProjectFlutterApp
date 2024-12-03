import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
import 'package:restaurant_app_level_one/screen/detail/restaurant_add_review_widget.dart';
import 'package:restaurant_app_level_one/screen/detail/restaurant_menus_widget.dart';
import 'package:restaurant_app_level_one/screen/detail/restaurant_reviews_widget.dart';
import 'package:restaurant_app_level_one/utils/global_function.dart';

import 'build_size_chip.dart';
import 'icon_text.dart';

class RestaurantDataWidget extends StatefulWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantDataWidget({super.key, required this.restaurantDetail});

  @override
  State<RestaurantDataWidget> createState() => _RestaurantDataWidgetState();
}

class _RestaurantDataWidgetState extends State<RestaurantDataWidget> {
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