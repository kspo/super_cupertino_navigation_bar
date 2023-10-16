import 'package:flutter/cupertino.dart';

class Carousel {
  Carousel({
    required this.title,
    required this.imageUrl,
    required this.screen,
  });

  String title;
  String imageUrl;
  Widget screen;
}

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
  final Widget screen;
  final String? imageUrl;
}
