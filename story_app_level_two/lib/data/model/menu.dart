import 'category.dart';

class Menu {
  List<Category> foods;
  List<Category> drinks;

  Menu.empty()
      : foods = [],
        drinks = [];

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
