import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class SearchFieldDecoration {
  SearchFieldDecoration({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.placeholderText,
    this.decoration,
    this.keyboardType = TextInputType.text,
    this.padding = const EdgeInsetsDirectional.fromSTEB(5.5, 8, 5.5, 8),
    this.prefixIconColor,
    this.placeholderColor,
    this.prefixInsets = const EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
    this.prefixIcon,
    this.suffixInsets = const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 2),
    this.suffixIcon = const Icon(CupertinoIcons.xmark_circle_fill),
    this.onSuffixTap,
    this.onCancelTap,
    this.paddingLeft = 16,
    this.paddingRight = 16,
    this.cancelButtonName = "Cancel",
    this.cancelButtonStyle = const TextStyle(
      color: CupertinoColors.systemBlue,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
    this.cursorColor = CupertinoColors.link,
    this.onFocused,
    this.hideSearchBarOnInit = false,
    this.searchFieldBehaviour =
        SearchFieldBehaviour.ShowResultScreenAfterFieldFocused,
    this.searchResultHeader = const SearchResultHeader(
      child: SizedBox(),
      height: 0,
    ),
    this.searchResultChildren = const [],
  });

  final TextEditingController? controller;
  final Color cursorColor;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onCancelTap;
  final String? placeholderText;
  final BoxDecoration? decoration;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry padding;
  final Color? prefixIconColor;
  final Color? placeholderColor;
  final EdgeInsetsGeometry prefixInsets;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry suffixInsets;
  final Icon suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<bool>? onFocused;
  final double paddingLeft;
  final double paddingRight;
  final String cancelButtonName;
  final TextStyle cancelButtonStyle;
  final bool hideSearchBarOnInit;
  final SearchFieldBehaviour searchFieldBehaviour;
  final SearchResultHeader searchResultHeader;
  final ValueChanged<String>? onChanged;
  final List<Widget> searchResultChildren;
  // final TextStyle? style;
// final TextStyle? placeholderStyle;
// final Color? backgroundColor;
// final BorderRadius? borderRadius;
// final double itemSize;
// final bool autofocus;
}

enum AppBarType {
  LargeTitleWithPinnedSearch,
  LargeTitleWithFloatedSearch,
  LargeTitleWithoutSearch,
  NormalNavbarWithPinnedSearch,
  NormalNavbarWithFloatedSearch,
  NormalNavbarWithoutSearch,
}

enum SearchFieldBehaviour {
  ShowResultScreenAfterFieldInput,
  ShowResultScreenAfterFieldFocused,
  NeverShowResultScreen,
}

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
