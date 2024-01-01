import 'package:flutter/cupertino.dart';

import 'back_chevron.dart';
import 'back_label.dart';

// A collection of keys always used when building static routes' nav bars's
// components with _NavigationBarStaticComponents and read in
// _NavigationBarTransition in Hero flights in order to reference the components'
// RenderBoxes for their positions.
//
// These keys should never re-appear inside the Hero flights.

// Based on various user Widgets and other parameters, construct KeyedSubtree
// components that are used in common by the CupertinoNavigationBar and
// CupertinoSliverNavigationBar. The KeyedSubtrees are inserted into static
// routes and the KeyedSubtrees' child are reused in the Hero flights.
@immutable
class NavigationBarStaticComponents {
  NavigationBarStaticComponents({
    required NavigationBarStaticComponentsKeys keys,
    required ModalRoute<dynamic>? route,
    required Widget? userLeading,
    required bool automaticallyImplyLeading,
    required bool automaticallyImplyTitle,
    required String? previousPageTitle,
    required Widget? userMiddle,
    required Widget? userTrailing,
    required Widget? userLargeTitle,
    required Widget? largeTitleActions,
    required Widget? appbarBottom,
    required EdgeInsetsDirectional? padding,
    required bool large,
  })  : leading = createLeading(
          leadingKey: keys.leadingKey,
          userLeading: userLeading,
          route: route,
          automaticallyImplyLeading: automaticallyImplyLeading,
          padding: padding,
        ),
        backChevron = createBackChevron(
          backChevronKey: keys.backChevronKey,
          userLeading: userLeading,
          route: route,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
        backLabel = createBackLabel(
          backLabelKey: keys.backLabelKey,
          userLeading: userLeading,
          route: route,
          previousPageTitle: previousPageTitle,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
        middle = createMiddle(
          middleKey: keys.middleKey,
          userMiddle: userMiddle,
          userLargeTitle: userLargeTitle,
          route: route,
          automaticallyImplyTitle: automaticallyImplyTitle,
          large: large,
        ),
        trailing = createTrailing(
          trailingKey: keys.trailingKey,
          userTrailing: userTrailing,
          padding: padding,
        ),
        largeTitle = createLargeTitle(
          largeTitleKey: keys.largeTitleKey,
          userLargeTitle: userLargeTitle,
          route: route,
          automaticImplyTitle: automaticallyImplyTitle,
          large: large,
        ),
        largeTitleActions = createLargeTitleActions(
          largeTitleActionsKey: keys.largeTitleActionsKey,
          largeTitleActions: largeTitleActions,
          padding: padding,
        ),
        appbarBottom = createAppbarBottom(
          appbarBottomKey: keys.appbarBottomKey,
          appbarBottom: appbarBottom,
          route: route,
        );

  static Widget? _derivedTitle({
    required bool automaticallyImplyTitle,
    ModalRoute<dynamic>? currentRoute,
  }) {
    // Auto use the CupertinoPageRoute's title if middle not provided.
    if (automaticallyImplyTitle &&
        currentRoute is CupertinoRouteTransitionMixin &&
        currentRoute.title != null) {
      return Text(currentRoute.title!);
    }

    return null;
  }

  final KeyedSubtree? leading;
  static KeyedSubtree? createLeading({
    required GlobalKey leadingKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
    required EdgeInsetsDirectional? padding,
  }) {
    Widget? leadingContent;

    if (userLeading != null) {
      leadingContent = userLeading;
    } else if (automaticallyImplyLeading &&
        route is PageRoute &&
        route.canPop &&
        route.fullscreenDialog) {
      leadingContent = CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          route.navigator!.maybePop();
        },
        child: const Text('Close'),
      );
    } else if (!automaticallyImplyLeading && userLeading == null) {
      /// this will help animate things whatever it takes
      leadingContent = const SizedBox();
    }

    if (leadingContent == null) {
      return null;
    }

    return KeyedSubtree(
      key: leadingKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: padding?.start ?? 0,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 32.0,
          ),
          child: leadingContent,
        ),
      ),
    );
  }

  final KeyedSubtree? backChevron;
  static KeyedSubtree? createBackChevron({
    required GlobalKey backChevronKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
  }) {
    if (userLeading != null ||
        !automaticallyImplyLeading ||
        route == null ||
        !route.canPop ||
        (route is PageRoute && route.fullscreenDialog)) {
      return null;
    }

    return KeyedSubtree(key: backChevronKey, child: const BackChevron());
  }

  /// This widget is not decorated with a font since the font style could
  /// animate during transitions.
  final KeyedSubtree? backLabel;
  static KeyedSubtree? createBackLabel({
    required GlobalKey backLabelKey,
    required Widget? userLeading,
    required ModalRoute<dynamic>? route,
    required bool automaticallyImplyLeading,
    required String? previousPageTitle,
  }) {
    if (userLeading != null ||
        !automaticallyImplyLeading ||
        route == null ||
        !route.canPop ||
        (route is PageRoute && route.fullscreenDialog)) {
      return null;
    }

    return KeyedSubtree(
      key: backLabelKey,
      child: BackLabel(
        specifiedPreviousTitle: previousPageTitle,
        route: route,
      ),
    );
  }

  /// This widget is not decorated with a font since the font style could
  /// animate during transitions.
  final KeyedSubtree? middle;
  static KeyedSubtree? createMiddle({
    required GlobalKey middleKey,
    required Widget? userMiddle,
    required Widget? userLargeTitle,
    required bool large,
    required bool automaticallyImplyTitle,
    required ModalRoute<dynamic>? route,
  }) {
    Widget? middleContent = userMiddle;

    if (large) {
      middleContent ??= userLargeTitle;
    }

    middleContent ??= _derivedTitle(
      automaticallyImplyTitle: automaticallyImplyTitle,
      currentRoute: route,
    );

    if (middleContent == null) {
      return null;
    }

    return KeyedSubtree(
      key: middleKey,
      child: middleContent,
    );
  }

  final KeyedSubtree? trailing;
  static KeyedSubtree? createTrailing({
    required GlobalKey trailingKey,
    required Widget? userTrailing,
    required EdgeInsetsDirectional? padding,
  }) {
    if (userTrailing == null) {
      return null;
    }

    return KeyedSubtree(
      key: trailingKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          end: padding?.end ?? 0,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 32.0,
          ),
          child: userTrailing,
        ),
      ),
    );
  }

  /// This widget is not decorated with a font since the font style could
  /// animate during transitions.
  final KeyedSubtree? largeTitle;
  static KeyedSubtree? createLargeTitle({
    required GlobalKey largeTitleKey,
    required Widget? userLargeTitle,
    required bool large,
    required bool automaticImplyTitle,
    required ModalRoute<dynamic>? route,
  }) {
    if (!large) {
      return null;
    }

    final Widget? largeTitleContent = userLargeTitle ??
        _derivedTitle(
          automaticallyImplyTitle: automaticImplyTitle,
          currentRoute: route,
        );

    assert(
      largeTitleContent != null,
      'largeTitle was not provided and there was no title from the route.',
    );

    return KeyedSubtree(
      key: largeTitleKey,
      child: largeTitleContent!,
    );
  }

  final KeyedSubtree? largeTitleActions;
  static KeyedSubtree? createLargeTitleActions({
    required GlobalKey largeTitleActionsKey,
    required Widget? largeTitleActions,
    required EdgeInsetsDirectional? padding,
  }) {
    if (largeTitleActions == null) {
      return null;
    }

    return KeyedSubtree(
      key: largeTitleActionsKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          end: padding?.end ?? 0,
        ),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 32.0,
          ),
          child: largeTitleActions,
        ),
      ),
    );
  }

  final KeyedSubtree? appbarBottom;
  static KeyedSubtree? createAppbarBottom({
    required GlobalKey appbarBottomKey,
    required Widget? appbarBottom,
    required ModalRoute<dynamic>? route,
  }) {
    return KeyedSubtree(
      key: appbarBottomKey,
      child: appbarBottom!,
    );
  }
}

@immutable
class NavigationBarStaticComponentsKeys {
  NavigationBarStaticComponentsKeys()
      : navBarBoxKey = GlobalKey(debugLabel: 'Navigation bar render box'),
        leadingKey = GlobalKey(debugLabel: 'Leading'),
        backChevronKey = GlobalKey(debugLabel: 'Back chevron'),
        backLabelKey = GlobalKey(debugLabel: 'Back label'),
        middleKey = GlobalKey(debugLabel: 'Middle'),
        trailingKey = GlobalKey(debugLabel: 'Trailing'),
        largeTitleKey = GlobalKey(debugLabel: 'Large title'),
        searchBarKey = GlobalKey(debugLabel: 'Search Bar'),
        largeTitleActionsKey = GlobalKey(debugLabel: 'largeTitleActionsKey'),
        appbarBottomKey = GlobalKey(debugLabel: 'appbarBottomKey');

  final GlobalKey navBarBoxKey;
  final GlobalKey leadingKey;
  final GlobalKey backChevronKey;
  final GlobalKey backLabelKey;
  final GlobalKey middleKey;
  final GlobalKey trailingKey;
  final GlobalKey largeTitleKey;
  final GlobalKey searchBarKey;
  final GlobalKey largeTitleActionsKey;
  final GlobalKey appbarBottomKey;
}
