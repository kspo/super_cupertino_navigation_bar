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
    this.actionButtons = const [],
    this.textStyle,
    this.placeholderTextStyle,
  });

  final TextStyle? textStyle;
  final TextStyle? placeholderTextStyle;
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
  final String cancelButtonName;
  final TextStyle cancelButtonStyle;
  final bool hideSearchBarOnInit;
  final SearchFieldBehaviour searchFieldBehaviour;
  final SearchResultHeader searchResultHeader;
  final ValueChanged<String>? onChanged;
  final List<Widget> searchResultChildren;
  final List<SearchBarActionButton> actionButtons;
}

class SearchBarActionButton extends StatelessWidget {
  const SearchBarActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.actionButtonsBehaviour =
        SearchFieldActionButtonsBehaviour.VisibleOnFocus,
  });
  final Icon icon;
  final VoidCallback? onPressed;
  final SearchFieldActionButtonsBehaviour actionButtonsBehaviour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: actionButtonsBehaviour ==
                SearchFieldActionButtonsBehaviour.VisibleOnFocus
            ? 15
            : 0,
        left: actionButtonsBehaviour ==
                    SearchFieldActionButtonsBehaviour.AlwaysVisible ||
                actionButtonsBehaviour ==
                    SearchFieldActionButtonsBehaviour.VisibleOnUnFocus
            ? 15
            : 0,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0,
        onPressed: onPressed,
        child: SizedBox(
          width: icon.size,
          child: icon,
        ),
      ),
    );
  }
}

enum AppBarType {
  // ignore: constant_identifier_names
  LargeTitleWithPinnedSearch,
  // ignore: constant_identifier_names
  LargeTitleWithFloatedSearch,
  // ignore: constant_identifier_names
  LargeTitleWithoutSearch,
  // ignore: constant_identifier_names
  NormalNavbarWithPinnedSearch,
  // ignore: constant_identifier_names
  NormalNavbarWithFloatedSearch,
  // ignore: constant_identifier_names
  NormalNavbarWithoutSearch,
}

enum SearchFieldBehaviour {
  // ignore: constant_identifier_names
  ShowResultScreenAfterFieldInput,
  // ignore: constant_identifier_names
  ShowResultScreenAfterFieldFocused,
  // ignore: constant_identifier_names
  NeverShowResultScreen,
}

enum SearchFieldActionButtonsBehaviour {
  // ignore: constant_identifier_names
  AlwaysVisible,
  // ignore: constant_identifier_names
  VisibleOnFocus,
  // ignore: constant_identifier_names
  VisibleOnUnFocus,
}

/*
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
*/
