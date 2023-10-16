import 'package:flutter/cupertino.dart';
import 'package:super_cupertino_navigation_bar/src/shared/back_button.dart';
import 'package:super_cupertino_navigation_bar/src/shared/measures.dart';
import 'package:super_cupertino_navigation_bar/src/shared/navigation_bar_static_components.dart';

/// The top part of the navigation bar that's never scrolled away.
///
/// Consists of the entire navigation bar without background and border when used
/// without large titles. With large titles, it's the top static half that
/// doesn't scroll.
class PersistentNavigationBar extends StatelessWidget {
  const PersistentNavigationBar({
    super.key,
    required this.components,
    this.padding,
    this.middleVisible,
  });

  final NavigationBarStaticComponents components;

  final EdgeInsetsDirectional? padding;

  /// Whether the middle widget has a visible animated opacity. A null value
  /// means the middle opacity will not be animated.
  final bool? middleVisible;

  @override
  Widget build(BuildContext context) {
    Widget? middle = components.middle;

    if (middle != null) {
      middle = DefaultTextStyle(
        style: CupertinoTheme.of(context)
            .textTheme
            .navTitleTextStyle
            .copyWith(fontWeight: FontWeight.w700),
        child: Semantics(header: true, child: middle),
      );
      // When the middle's visibility can change on the fly like with large title
      // slivers, wrap with animated opacity.
      middle = middleVisible == null
          ? middle
          : AnimatedOpacity(
              opacity: middleVisible! ? 1.0 : 0.0,
              duration: Measures.persistentNavbarFadeDurationAfterThreshold,
              child: middle,
            );
    }

    Widget? leading = components.leading;
    final Widget? backChevron = components.backChevron;
    final Widget? backLabel = components.backLabel;

    if (leading == null && backChevron != null && backLabel != null) {
      leading = ExtendedCupertinoNavigationBarBackButton.assemble(
        backChevron,
        backLabel,
      );
    }

    Widget paddedToolbar = NavigationToolbar(
      leading: leading,
      middle: middle,
      trailing: components.trailing,
      middleSpacing: 6.0,
    );

    if (padding != null) {
      paddedToolbar = Padding(
        padding: EdgeInsets.only(
          top: padding!.top,
          bottom: padding!.bottom,
        ),
        child: paddedToolbar,
      );
    }

    return SizedBox(
      height:
          Measures.navBarPersistentHeight + MediaQuery.paddingOf(context).top,
      child: SafeArea(
        bottom: false,
        child: paddedToolbar,
      ),
    );
  }
}
