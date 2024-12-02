import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/model/category.dart';
import 'package:restaurant_app_level_one/data/model/menu_list.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
import 'package:restaurant_app_level_one/data/model/review_request.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_review_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_review_result.dart';
import 'package:restaurant_app_level_one/utils/global_function.dart';

import 'build_size_chip.dart';
import 'comment_card.dart';
import 'icon_text.dart';
import 'menus_card.dart';

class DetailRestaurantBodyWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const DetailRestaurantBodyWidget({
    super.key,
    required this.restaurantDetail,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> listCategoriesWidget = restaurantDetail.categories
        .map((category) => buildSizeChip(category.name))
        .toList();

    List<ListMenu> listAllMenu = [];
    List<Category> listMenuFood = restaurantDetail.menus.foods;
    for (int index = 0; index < listMenuFood.length; index++) {
      var food = listMenuFood[index];
      listAllMenu.add(ListMenu(food.name, true, false));
    }
    List<Category> listMenuDrink = restaurantDetail.menus.drinks;
    for (int index = 0; index < listMenuDrink.length; index++) {
      var drink = listMenuDrink[index];
      listAllMenu.add(ListMenu(drink.name, false, true));
    }

    final reviewProvider = Provider.of<RestaurantReviewProvider>(context);

    TextEditingController nameController = TextEditingController();
    TextEditingController reviewController = TextEditingController();

    return CustomScrollView(
      slivers: [
        // SliverAppBar with the image
        SliverAppBar(
          expandedHeight: 350,
          pinned: true,
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // SliverList for the details section
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Name and Counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurantDetail.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                spaceVertical(10),
                Text(
                  restaurantDetail.address,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                    IconText(icon: Icons.star, label: restaurantDetail.rating.toString()),
                    IconText(icon: Icons.location_city, label: restaurantDetail.city),
                  ],
                ),
                spaceVertical(20),
                Text(
                  restaurantDetail.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                spaceVertical(15),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Menu Food and Drink',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 1,
                  child: Container(color: Colors.grey,),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 4,
                  children: listAllMenu.map((item) {
                    return MenusCard(
                      listMenu: item,
                    );
                  }).toList(),
                ),
                spaceVertical(15),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Reviews',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 1,
                  child: Container(color: Colors.grey,),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurantDetail.customerReviews.length,
                  itemBuilder: (context, index) {
                    return CustomerReviewCard(
                      customerReview: restaurantDetail.customerReviews[index],
                    );
                  },
                ),
                spaceVertical(15),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: const Text('Add Review'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextField(
                                  controller: reviewController,
                                  decoration: const InputDecoration(
                                    labelText: 'Review',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 15),
                                // Tempatkan Consumer di sini untuk memantau status dari provider
                                Consumer<RestaurantReviewProvider>(
                                  builder: (context, provider, child) {
                                    return provider.resultState is RestaurantReviewLoadingState
                                        ? const CircularProgressIndicator()
                                        : const SizedBox();  // Tampilkan progress indicator saat loading
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final name = nameController.text;
                                  final review = reviewController.text;

                                  if (name.isNotEmpty && review.isNotEmpty) {
                                    final reviewRequest = ReviewRequest(
                                      restaurantDetail.id,
                                      name,
                                      review,
                                    );

                                    context.read<RestaurantReviewProvider>().fetchRestaurantReview(reviewRequest);
                                    Future.delayed(const Duration(seconds: 1), () {
                                      final resultState = context.read<RestaurantReviewProvider>().resultState;

                                      if (resultState is RestaurantReviewLoadedState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Review added successfully!"),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      } else if (resultState is RestaurantReviewErrorState) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Failed to add review: ${resultState.error}"),
                                            backgroundColor: Colors.red,
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please fill in both fields')),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    child: Text(
                      'Add Review',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}