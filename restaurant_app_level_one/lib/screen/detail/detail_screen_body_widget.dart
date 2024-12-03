import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
import 'package:restaurant_app_level_one/screen/detail/restaurant_data_widget.dart';
import 'package:restaurant_app_level_one/screen/detail/restaurant_image_widget.dart';


class DetailScreenBodyWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const DetailScreenBodyWidget({
    super.key,
    required this.restaurantDetail,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        RestaurantImageWidget(restaurantDetail: restaurantDetail),
        /*SliverAppBar(
          expandedHeight: 350,
          pinned: true,
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              restaurantDetail.name,
              style: const TextStyle(color: Colors.white),
            ),
            background: Hero(
              tag: 'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),*/
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
            child: RestaurantDataWidget(restaurantDetail: restaurantDetail),
            /*child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                textCenter('Menu Food and Drink'),
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
                textCenter('Reviews'),
                SizedBox(
                  height: 1,
                  child: Container(color: Colors.grey,),
                ),
                Consumer<RestaurantReviewProvider>(
                  builder: (context, provider, child) {
                    final count = provider.customerReviews.length;
                    final listReviewCustomer = count > 0 ? provider.customerReviews : restaurantDetail.customerReviews;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listReviewCustomer.length,
                      itemBuilder: (context, index) {
                        return CustomerReviewCard(
                          customerReview: listReviewCustomer[index],
                        );
                      },
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
                                Consumer<RestaurantReviewProvider>(
                                  builder: (context, provider, child) {
                                    return provider.resultState is RestaurantReviewLoadingState
                                        ? const CircularProgressIndicator()
                                        : const SizedBox();
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
                                onPressed: () async {
                                  final name = nameController.text;
                                  final review = reviewController.text;

                                  if (name.isNotEmpty && review.isNotEmpty) {
                                    final reviewRequest = ReviewRequest(
                                      restaurantDetail.id,
                                      name,
                                      review,
                                    );

                                    try {
                                      context.read<RestaurantReviewProvider>().fetchRestaurantReview(reviewRequest);
                                      Future.delayed(const Duration(seconds: 1), () async {
                                        final resultState = context.read<RestaurantReviewProvider>().resultState;

                                        if (resultState is RestaurantReviewLoadedState) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Review added successfully!"),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                          final listCustomerReviewNew = resultState.data;
                                          context.read<RestaurantReviewProvider>().addReview(listCustomerReviewNew);
                                          Navigator.of(context).pop();
                                        } else if (resultState is RestaurantReviewErrorState) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Failed to add review: ${resultState.error}"),
                                              backgroundColor: Colors.red,
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Failed to add review: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
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
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    child: const Text(
                      'Add Review',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),*/
          ),
        ),
      ],
    );
  }
}