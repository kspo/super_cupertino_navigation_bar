import 'package:flutter/cupertino.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar.model.dart';

class SuperAction extends StatelessWidget {
  const SuperAction({
    super.key,
    required this.child,
    this.behavior = SuperActionBehavior.visibleOnFocus,
  });
  final Widget child;
  final SuperActionBehavior behavior;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
