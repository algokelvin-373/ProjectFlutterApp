import 'package:flutter/material.dart';

class ProfileData {
  final List<Map<String, dynamic>> infoList = [
    {
      'icon': Icons.verified_user,
      'label': '用户名',
      'value': '用户名',
    }, // For data username
    {
      'icon': Icons.email,
      'label': '电子邮件',
      'value': 'dilerragip@gmail.com',
    }, // For data email
    {
      'icon': Icons.phone,
      'label': '电话',
      'value': '+1 (555)-555-5555',
    }, // For data phone
    {
      'icon': Icons.work,
      'label': '工作',
      'value': 'Android开发者',
    }, // For data job title
    {
      'icon': Icons.location_on,
      'label': '地点',
      'value': '。。。',
    }, // For data location
  ];
}
