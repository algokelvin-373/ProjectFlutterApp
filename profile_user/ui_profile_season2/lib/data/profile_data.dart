import 'package:flutter/material.dart';

class ProfileData {
  final List<Map<String, dynamic>> infoList = [
    {
      'icon': Icons.verified_user,
      'label': 'Username',
      'value': 'username',
    }, // For data username
    {
      'icon': Icons.email,
      'label': 'Email',
      'value': 'dilerragip@gmail.com',
    }, // For data email
    {
      'icon': Icons.phone,
      'label': 'Phone',
      'value': '+1 (555)-555-5555',
    }, // For data phone
    {
      'icon': Icons.work,
      'label': 'Job Title',
      'value': 'Product Designer',
    }, // For data job
    {
      'icon': Icons.location_on,
      'label': 'Location',
      'value': 'Angara, Turkey',
    }, // For data location
  ];
}
