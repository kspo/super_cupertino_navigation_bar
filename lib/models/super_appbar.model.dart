import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/models/super_appbar_bottom.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_large_title.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar.model.dart';

class SuperAppBar {
  SuperAppBar({
    this.title,
    this.actions,
    this.height = kToolbarHeight,
    this.leadingWidth,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.titleSpacing = 15,
    this.previousPageTitle = "Back",
    this.alwaysShowTitle = false,
    this.searchBar,
    this.largeTitle,
    this.bottom,
    this.backgroundColor,
    this.bottomBorder,
    this.shadowColor,
  }) {
    searchBar = searchBar ?? SuperSearchBar();
    largeTitle = largeTitle ?? SuperLargeTitle();
    bottom = bottom ?? SuperAppBarBottom();

    if (!searchBar!.enabled) {
      searchBar!.height = 0;
    }
    if (!largeTitle!.enabled) {
      largeTitle!.height = 0;
    }
    if (!bottom!.enabled) {
      bottom!.height = 0;
    }
    title ??= Text(largeTitle!.largeTitle);

    if (title is Text) {
      if ((title as Text).style == null) {
        title = Text(
          "${(title as Text).data}",
          style: const TextStyle(),
        );
      }
    }
  }

  Widget? title;
  final Widget? actions;
  final double height;
  final Widget? leading;
  final double titleSpacing;
  final String previousPageTitle;
  final bool alwaysShowTitle;
  final double? leadingWidth;
  SuperSearchBar? searchBar;
  SuperLargeTitle? largeTitle;
  SuperAppBarBottom? bottom;
  final Color? backgroundColor;
  final BorderSide? bottomBorder;
  final Color? shadowColor;
  final bool automaticallyImplyLeading;
}
