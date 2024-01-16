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
    this.border,
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

  /// {@template flutter.material.appbar.title}
  /// The primary widget displayed in the app bar.
  ///
  /// Becomes the middle component of the [NavigationToolbar] built by this widget.
  ///
  /// Typically a [Text] widget that contains a description of the current
  /// contents of the app.
  /// {@endtemplate}
  ///
  /// The [title]'s width is constrained to fit within the remaining space
  /// between the toolbar's [leading] and [actions] widgets. Its height is
  /// _not_ constrained. The [title] is vertically centered and clipped to fit
  /// within the toolbar, whose height is [toolbarHeight]. Typically this
  /// isn't noticeable because a simple [Text] [title] will fit within the
  /// toolbar by default. On the other hand, it is noticeable when a
  /// widget with an intrinsic height that is greater than [toolbarHeight]
  /// is used as the [title]. For example, when the height of an Image used
  /// as the [title] exceeds [toolbarHeight], it will be centered and
  /// clipped (top and bottom), which may be undesirable. In cases like this
  /// the height of the [title] widget can be constrained. For example:
  ///
  /// ```dart
  /// MaterialApp(
  ///   home: Scaffold(
  ///     appBar: AppBar(
  ///       title: SizedBox(
  ///         height: _myToolbarHeight,
  ///         child: Image.asset(_logoAsset),
  ///       ),
  ///       toolbarHeight: _myToolbarHeight,
  ///     ),
  ///   ),
  /// )
  /// ```
  Widget? title;

  final Widget? actions;

  /// {@template flutter.material.appbar.toolbarHeight}
  /// Defines the height of the toolbar component of an [AppBar].
  ///
  /// By default, the value of [toolbarHeight] is [kToolbarHeight].
  /// {@endtemplate}
  final double height;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.leading}
  ///
  /// This widget is visible in both collapsed and expanded states.
  final Widget? leading;

  final double titleSpacing;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.previousPageTitle}
  final String previousPageTitle;

  /// Controls whether [middle] widget should always be visible (even in
  /// expanded state).
  ///
  /// If true (default) and [middle] is not null, [middle] widget is always
  /// visible. If false, [middle] widget is visible only in collapsed state if
  /// it is provided.
  ///
  /// This should be set to false if you only want to show [largeTitle] in
  /// expanded state and [middle] in collapsed state.
  final bool alwaysShowTitle;
  final double? leadingWidth;
  SuperSearchBar? searchBar;
  SuperLargeTitle? largeTitle;
  SuperAppBarBottom? bottom;
  final Color? backgroundColor;

  /// {@macro flutter.cupertino.CupertinoNavigationBar.border}
  final Border? border;
  final Color? shadowColor;

  /// {@template flutter.material.appbar.automaticallyImplyLeading}
  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  /// {@endtemplate}
  final bool automaticallyImplyLeading;
}
