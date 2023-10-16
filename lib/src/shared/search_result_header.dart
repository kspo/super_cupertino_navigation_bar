import 'package:flutter/cupertino.dart';

class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader({
    super.key,
    required this.height,
    required this.child,
  });
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
