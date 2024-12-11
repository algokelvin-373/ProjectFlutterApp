import 'package:flutter/material.dart';

import '../../data/model/category.dart';
import '../../data/model/menu_list.dart';
import '../../data/model/restaurant_detail.dart';
import 'menus_card.dart';

class RestaurantMenusWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantMenusWidget({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
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

    return GridView.count(
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
    );
  }
}