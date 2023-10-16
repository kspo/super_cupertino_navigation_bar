import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:super_cupertino_navigation_bar/src/shared/persistent_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/src/shared/transitionable_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../shared/large_title.dart';
import '../shared/measures.dart';
import '../shared/navigation_bar_static_components.dart';

class LargeTitleWithoutSearch extends StatelessWidget
    with DiagnosticableTreeMixin {
  LargeTitleWithoutSearch({
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
    required this.hasFocusValueNotifier,
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
  final ValueNotifier<bool> hasFocusValueNotifier;

  @override
  Widget build(BuildContext context) {
    final bool showLargeTitle = scrollController.offset >
        Measures.navBarLargeTitleHeight -
            Measures.navBarShowLargeTitleThreshold;

    final PersistentNavigationBar persistentNavigationBar =
        PersistentNavigationBar(
      components: components,
      padding: padding,
      // If a user specified middle exists, always show it. Otherwise, show
      // title when sliver is collapsed.
      middleVisible: alwaysShowMiddle ? null : showLargeTitle,
    );

    final Widget navBar = wrapWithBackground(
      border: border,
      backgroundColor: showLargeTitle
          ? CupertinoDynamicColor.resolve(collapsedBackgroundColor, context)
          : CupertinoDynamicColor.resolve(backgroundColor, context),
      brightness: brightness,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: persistentHeight,
              left: 0.0,
              right: 0.0,
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),

                /// this used for search bar has focus
                opacity: hasFocusValueNotifier.value ? 0 : 1,
                child: ClipRect(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: Measures.navBarEdgePadding,
                      bottom: Measures.navBarBottomPadding,
                    ),
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: AnimatedOpacity(
                        /// this used for scroll
                        opacity: showLargeTitle ? 0.0 : 1.0,
                        duration: Measures.navBarTitleFadeDuration,
                        child: Semantics(
                          header: true,
                          child: DefaultTextStyle(
                            style: Measures.largeTitleTextStyle(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            child: LargeTitle(
                              child: components.largeTitle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            avatarModel.avatarIsVisible
                ? Positioned(
                    right: 15.0,
                    top: persistentHeight,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: avatarModel.onTap,
                      child: ClipRect(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: Measures.navBarEdgePadding,
                            bottom: Measures.navBarBottomPadding + 3,
                          ),
                          child: SafeArea(
                            top: false,
                            bottom: false,
                            child: AnimatedOpacity(
                              /// this used for scroll
                              opacity: showLargeTitle ? 0.0 : 1.0,
                              duration: Measures.navBarTitleFadeDuration,
                              child: Container(
                                transform: Matrix4.translationValues(
                                    0,
                                    clampDouble(4 - scrollController.offset,
                                        -Measures.searchBarHeight, 0),
                                    0),
                                alignment: AlignmentDirectional.bottomStart
                                    .resolve(Directionality.of(context)),
                                child: avatarModel.avatarUrl != null
                                    ? Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                avatarModel.avatarUrl!),
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        avatarModel.icon,
                                        size: 34,
                                        color: avatarModel.avatarIconColor,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
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
        backgroundColor:
            CupertinoDynamicColor.resolve(backgroundColor, context),
        backButtonTextStyle:
            CupertinoTheme.of(context).textTheme.navActionTextStyle,
        titleTextStyle: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        largeTitleTextStyle: Measures.largeTitleTextStyle(context),
        border: border,
        hasUserMiddle:
            userMiddle != null && (alwaysShowMiddle || showLargeTitle),
        largeExpanded: !showLargeTitle,
        searchBarHasFocus: false,
        child: navBar,
      ),
    );
  }
}
