import 'package:flutter/material.dart';

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
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
