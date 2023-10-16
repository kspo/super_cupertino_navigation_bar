import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:super_cupertino_navigation_bar/src/shared/persistent_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/src/shared/search_field_widget.dart';
import 'package:super_cupertino_navigation_bar/src/shared/transitionable_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../shared/measures.dart';
import '../shared/navigation_bar_static_components.dart';

class NormalNavbarWithPinnedSearch extends StatelessWidget
    with DiagnosticableTreeMixin {
  NormalNavbarWithPinnedSearch({
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
    final bool showLargeTitle = scrollController.offset >
        Measures.searchBarHeight +
            Measures.navBarLargeTitleHeight -
            Measures.navBarShowLargeTitleThreshold;

    final PersistentNavigationBar persistentNavigationBar =
        PersistentNavigationBar(
      components: components,
      padding: padding,
    );

    final bool changeBg = scrollController.offset >
        Measures.searchBarHeight +
            Measures.navBarLargeTitleHeight +
            Measures.collapsedBottomPadding;

    final Widget navBar = wrapWithBackground(
      border: border,
      backgroundColor: changeBg
          ? CupertinoDynamicColor.resolve(collapsedBackgroundColor, context)
          : CupertinoDynamicColor.resolve(backgroundColor, context),
      brightness: brightness,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15.0,
              right: 15.0,
              bottom: Measures.normalNavbarCollapsedBottomPadding,
              child: SizedBox(
                height: Measures.searchBarHeight,
                child: SearchBarWidget(
                  hasDataValueNotifier: hasDataValueNotifier,
                  hasFocusValueNotifier: hasFocusValueNotifier,
                  searchKey: keys.searchBarKey,
                  searchFieldDecoration: searchFieldDecoration,
                  opacityRate:
                      clampDouble(1 - (scrollController.offset / 7), 0, 1),
                  animationController: animationController,
                  focusNode: focusNode,
                  textEditingController: textEditingController,
                  largeTitleType: AppBarType.LargeTitleWithPinnedSearch,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: IgnorePointer(
                ignoring: hasFocusValueNotifier.value,
                child: AnimatedOpacity(
                  curve: hasFocusValueNotifier.value
                      ? const Cubic(0, 0.98, 0.35, 0.97)
                      : const Cubic(0.999, 0, 0.99, 0.01),
                  opacity: !hasFocusValueNotifier.value ? 1 : 0,
                  duration: !hasFocusValueNotifier.value
                      ? const Duration(milliseconds: 200)
                      : const Duration(milliseconds: 400),
                  child: persistentNavigationBar,
                ),
              ),
            ),
          ],
        ),
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
