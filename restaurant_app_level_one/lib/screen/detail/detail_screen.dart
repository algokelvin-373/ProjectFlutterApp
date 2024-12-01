import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/model/category.dart';
import 'package:restaurant_app_level_one/data/model/customer_review.dart';
import 'package:restaurant_app_level_one/data/model/menu_list.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_detaill_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_detail_result.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(data: var restaurant) =>
                DetailRestaurantBodyWidget(restaurantDetail: restaurant),
            RestaurantDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

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
            decoration: BoxDecoration(
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
                SizedBox(height: 10),
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

// Reusable IconText Widget
class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

// Category
Widget buildSizeChip(String size) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        size,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// Menu Food and Drink
class MenusCard extends StatelessWidget {
  final ListMenu listMenu;

  const MenusCard({
    super.key,
    required this.listMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset((listMenu.isFood) ? 'images/ic_food.jpg' : 'images/ic_drink.jpg',
              height: 100,
              fit: BoxFit.cover
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              listMenu.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Comment Card
class CustomerReviewCard extends StatelessWidget {
  final CustomerReview customerReview;

  const CustomerReviewCard({
    super.key,
    required this.customerReview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          Image.asset('images/ic_profile.jpg',
              height: 20,
              fit: BoxFit.cover
          ),
          SizedBox(width: 10), // Space between image and text
          // Username and Comment
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white), // Set default text color
                children: [
                  TextSpan(
                    text: customerReview.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' ${customerReview.review}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}