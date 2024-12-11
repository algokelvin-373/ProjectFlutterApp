import 'package:flutter/material.dart';

import '../../data/model/menu_list.dart';

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
              fit: BoxFit.cover,
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