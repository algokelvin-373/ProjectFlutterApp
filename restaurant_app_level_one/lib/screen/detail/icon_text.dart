import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/utils/global_function.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconText({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent),
        spaceHorizontal(5),
        Text(
          label,
          style: const TextStyle(
              fontSize: 14
          ),
        ),
      ],
    );
  }
}