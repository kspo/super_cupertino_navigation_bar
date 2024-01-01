import 'package:flutter/material.dart';

class SuperAppBarBottom {
  SuperAppBarBottom({
    this.child = const SizedBox(),
    this.height = 35,
    this.enabled = false,
    this.color = Colors.transparent,
  });

  Widget? child;
  double height;
  final bool enabled;
  final Color color;
}
