import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar_action.model.dart';

class SuperSearchBar {
  final String cancelButtonText;
  final TextStyle cancelTextStyle;
  final TextStyle placeholderTextStyle;
  final String placeholderText;
  final Icon prefixIcon;
  final List<SuperAction> actions;
  final SearchBarScrollBehavior scrollBehavior;

  /// {@template flutter.material.appbar.toolbarHeight}
  /// Defines the height of the toolbar component of an [AppBar].
  ///
  /// By default, the value of [toolbarHeight] is [kToolbarHeight].
  /// {@endtemplate}
  double height;

  final EdgeInsets padding;
  final SearchBarAnimationBehavior animationBehavior;
  final Duration animationDuration;
  final Widget searchResult;
  final SearchBarResultBehavior resultBehavior;
  final bool enabled;
  final TextStyle textStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocused;
  final ValueChanged<String>? onSubmitted;
  TextEditingController? searchController;
  FocusNode? searchFocusNode;
  final Color backgroundColor;
  final Color? resultColor;

  SuperSearchBar({
    this.resultColor,
    this.backgroundColor = CupertinoColors.tertiarySystemFill,
    this.cancelButtonText = "Cancel",
    this.placeholderText = "Search",
    this.enabled = true,
    this.scrollBehavior = SearchBarScrollBehavior.floated,
    this.animationBehavior = SearchBarAnimationBehavior.top,
    this.resultBehavior = SearchBarResultBehavior.visibleOnFocus,
    this.animationDuration = const Duration(milliseconds: 250),
    this.placeholderTextStyle =
        const TextStyle(color: CupertinoColors.systemGrey),
    this.cancelTextStyle = const TextStyle(color: CupertinoColors.systemBlue),
    this.prefixIcon = const Icon(
      CupertinoIcons.search,
    ),
    this.actions = const <SuperAction>[],
    this.height = 40,
    this.padding = const EdgeInsets.symmetric(horizontal: 15.0),
    this.searchResult = const Text(
      ".",
      style: TextStyle(
        color: Colors.transparent,
      ),
    ),
    this.textStyle = const TextStyle(),
    this.onChanged,
    this.onSubmitted,
    this.onFocused,
    this.searchController,
    this.searchFocusNode,
  });
}

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

enum SearchBarScrollBehavior {
  pinned,
  floated,
}

enum SearchBarAnimationBehavior {
  top,
  steady,
}

enum SearchBarResultBehavior {
  visibleOnFocus,
  visibleOnInput,
  neverVisible,
}

enum SuperActionBehavior {
  alwaysVisible,
  visibleOnFocus,
  visibleOnUnFocus,
}
