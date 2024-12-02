import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/model/restaurant.dart';
import 'package:restaurant_app_level_one/static/navigation_route.dart';
import 'package:restaurant_app_level_one/utils/global_function.dart';

class FoodItemCard extends StatelessWidget {
  final Restaurant restaurant;

  const FoodItemCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      elevation: 4,
      margin: verticalSymmetric(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}', // Replace with actual image URL
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            spaceHorizontal(10),
            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  spaceVertical(5),
                  Text(
                    restaurant.city,
                    style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceVertical(5),
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Add Cart Button
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    NavigationRoute.detailRoute.name,
                    arguments: restaurant.id,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text('Kunjungi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}