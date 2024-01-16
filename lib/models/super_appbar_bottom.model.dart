import 'package:flutter/material.dart';

class SuperAppBarBottom {
  SuperAppBarBottom({
    this.child = const SizedBox(),
    this.height = 35,
    this.enabled = false,
    this.color = Colors.transparent,
  });

  Widget? child;

  /// {@template flutter.material.appbar.toolbarHeight}
  /// Defines the height of the toolbar component of an [AppBar].
  ///
  /// By default, the value of [toolbarHeight] is [kToolbarHeight].
  /// {@endtemplate}
  double height;

  final bool enabled;
  final Color color;
}
