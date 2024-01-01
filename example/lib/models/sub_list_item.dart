import 'package:flutter/cupertino.dart';

class SubListItem {
  SubListItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.screen,
    this.imageUrl,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final String screen;
  final String? imageUrl;
}
