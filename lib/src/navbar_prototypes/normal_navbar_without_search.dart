import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:super_cupertino_navigation_bar/src/shared/persistent_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/src/shared/transitionable_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../shared/measures.dart';
import '../shared/navigation_bar_static_components.dart';

class NormalNavbarWithoutSearch extends StatelessWidget
    with DiagnosticableTreeMixin {
  NormalNavbarWithoutSearch({
    super.key,
    required this.keys,
    required this.components,
    required this.userMiddle,
    required this.backgroundColor,
    required this.brightness,
    required this.border,
    required this.padding,
    required this.actionsForegroundColor,
    required this.transitionBetweenRoutes,
    required this.heroTag,
    required this.persistentHeight,
    required this.alwaysShowMiddle,
    required this.scrollController,
    required this.searchFieldDecoration,
    required this.animationController,
    required this.focusNode,
    required this.collapsedBackgroundColor,
    required this.avatarModel,
    required this.textEditingController,
    required this.hasFocusValueNotifier,
    required this.hasDataValueNotifier,
  });

  final SearchFieldDecoration searchFieldDecoration;
  final NavigationBarStaticComponentsKeys keys;
  final NavigationBarStaticComponents components;
  final Widget? userMiddle;
  final Color backgroundColor;
  final Color collapsedBackgroundColor;
  final Brightness? brightness;
  final Border? border;
  final EdgeInsetsDirectional? padding;
  final Color actionsForegroundColor;
  final bool transitionBetweenRoutes;
  final Object heroTag;
  final double persistentHeight;
  final bool alwaysShowMiddle;
  final ScrollController scrollController;
  final AnimationController animationController;
  final FocusNode focusNode;
  final AvatarModel avatarModel;
  final TextEditingController textEditingController;
  final ValueNotifier<bool> hasFocusValueNotifier;
  final ValueNotifier<bool> hasDataValueNotifier;

  @override
  Widget build(BuildContext context) {
    final PersistentNavigationBar persistentNavigationBar =
        PersistentNavigationBar(
      components: components,
      padding: padding,
    );

    final bool changeBg =
        scrollController.offset > Measures.collapsedBottomPadding;

    final Widget navBar = wrapWithBackground(
      border: border,
      backgroundColor: changeBg
          ? CupertinoDynamicColor.resolve(collapsedBackgroundColor, context)
          : CupertinoDynamicColor.resolve(backgroundColor, context),
      brightness: brightness,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: persistentNavigationBar,
      ),
    );

    if (!transitionBetweenRoutes || !isTransitionable(context)) {
      return navBar;
    }

    // print("2 = ${0.0 + Measure.kSearchHeight - scrollController.offset}");
    return Hero(
      tag: heroTag == Measures.defaultHeroTag
          ? HeroTag(Navigator.of(context))
          : heroTag,
      createRectTween: linearTranslateWithLargestRectSizeTween,
      flightShuttleBuilder: navBarHeroFlightShuttleBuilder,
      placeholderBuilder: navBarHeroLaunchPadBuilder,
      transitionOnUserGestures: true,
      // This is all the way down here instead of being at the top level of
      // CupertinoSliverNavigationBar like CupertinoNavigationBar because it
      // needs to wrap the top level RenderBox rather than a RenderSliver.
      child: TransitionableNavigationBar(
        componentsKeys: keys,
        backgroundColor: backgroundColor,
        backButtonTextStyle:
            CupertinoTheme.of(context).textTheme.navActionTextStyle,
        titleTextStyle: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        largeTitleTextStyle: null,
        border: border,
        hasUserMiddle: userMiddle != null,
        largeExpanded: false,
        searchBarHasFocus: false,
        child: navBar,
      ),
    );
  }
}
