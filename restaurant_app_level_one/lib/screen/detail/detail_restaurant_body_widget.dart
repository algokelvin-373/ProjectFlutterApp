import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/model/category.dart';
import 'package:restaurant_app_level_one/data/model/menu_list.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
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
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                spaceVertical(10),
                Text(
                  restaurantDetail.address,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 15),
                Wrap(
                  spacing: 4, // Horizontal spacing between chips
                  runSpacing: 4, // Vertical spacing if they wrap to the next line
                  alignment: WrapAlignment.start, // Align to the start
                  children: listCategoriesWidget,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconText(icon: Icons.star, label: restaurantDetail.rating.toString()),
                    IconText(icon: Icons.location_city, label: restaurantDetail.city),
                  ],
                ),
                SizedBox(height: 20),
                // Nutritional Info
                Text(
                  restaurantDetail.description,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 15),
                Align(
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
                  shrinkWrap: true, // Important to make GridView fit within Column
                  physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8, // Horizontal spacing
                  mainAxisSpacing: 8, // Vertical spacing
                  childAspectRatio: 3 / 4, // Adjust aspect ratio based on design
                  children: listAllMenu.map((item) {
                    return MenusCard(
                      listMenu: item,
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                Align(
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
                GridView.count(
                  shrinkWrap: true, // Important to make GridView fit within Column
                  physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                  crossAxisCount: 1, // Number of columns
                  crossAxisSpacing: 0, // Horizontal spacing
                  mainAxisSpacing: 0, // Vertical spacing
                  //childAspectRatio: 3 / 4, // Adjust aspect ratio based on design
                  children: restaurantDetail.customerReviews.map((item) {
                    return CustomerReviewCard(
                      customerReview: item,
                    );
                  }).toList(),
                ),
                /*Expanded(
                  child: ListView.builder(
                    itemCount: restaurantDetail.customerReviews.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final review = restaurantDetail.customerReviews[index];
                      return CustomerReviewCard(customerReview: review);
                    }
                  ),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '\$30.00',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    child: Text(
                      'Add to cart',
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