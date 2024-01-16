import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:super_cupertino_navigation_bar/utils/transitionable_navigation_bar.dart';

/// Returns `child` wrapped with background and a bottom border if background color
/// is opaque. Otherwise, also blur with [BackdropFilter].
///
/// When `updateSystemUiOverlay` is true, the nav bar will update the OS
/// status bar's color theme based on the background color of the nav bar.

Widget wrapWithBackground({
  Border? border,
  required Color backgroundColor,
  Brightness? brightness,
  required Widget child,
  bool updateSystemUiOverlay = true,
}) {
  Widget result = child;
  if (updateSystemUiOverlay) {
    final bool isDark = backgroundColor.computeLuminance() < 0.179;
    final Brightness newBrightness =
        brightness ?? (isDark ? Brightness.dark : Brightness.light);
    final SystemUiOverlayStyle overlayStyle;
    switch (newBrightness) {
      case Brightness.dark:
        overlayStyle = SystemUiOverlayStyle.light;
        break;
      case Brightness.light:
        overlayStyle = SystemUiOverlayStyle.dark;
        break;
    }
    // [SystemUiOverlayStyle.light] and [SystemUiOverlayStyle.dark] set some system
    // navigation bar properties,
    // Before https://github.com/flutter/flutter/pull/104827 those properties
    // had no effect, now they are used if there is no AnnotatedRegion on the
    // bottom of the screen.
    // For backward compatibility, create a `SystemUiOverlayStyle` without the
    // system navigation bar properties.
    result = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: overlayStyle.statusBarColor,
        statusBarBrightness: overlayStyle.statusBarBrightness,
        statusBarIconBrightness: overlayStyle.statusBarIconBrightness,
        systemStatusBarContrastEnforced:
            overlayStyle.systemStatusBarContrastEnforced,
      ),
      child: result,
    );
  }
  final DecoratedBox childWithBackground = DecoratedBox(
    decoration: BoxDecoration(
      border: border,
      color: backgroundColor,
    ),
    child: result,
  );

  if (backgroundColor.alpha == 0xFF) {
    return childWithBackground;
  }

  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: childWithBackground,
    ),
  );
}

// Whether the current route supports nav bar hero transitions from or to.
bool isTransitionable(BuildContext context) {
  final ModalRoute<dynamic>? route = ModalRoute.of(context);

  // Fullscreen dialogs never transitions their nav bar with other push-style
  // pages' nav bars or with other fullscreen dialog pages on the way in or on
  // the way out.
  return route is PageRoute && !route.fullscreenDialog;
}

/// Navigation bars' hero rect tween that will move between the static bars
/// but keep a constant size that's the bigger of both navigation bars.
RectTween linearTranslateWithLargestRectSizeTween(Rect? begin, Rect? end) {
  final Size largestSize = Size(
    max(begin!.size.width, end!.size.width),
    max(begin.size.height, end.size.height),
  );
  return RectTween(
    begin: begin.topLeft & largestSize,
    end: end.topLeft & largestSize,
  );
}

Widget navBarHeroLaunchPadBuilder(
  BuildContext context,
  Size heroSize,
  Widget child,
) {
  assert(child is TransitionableNavigationBar);
  // Tree reshaping is fine here because the Heroes' child is always a
  // _TransitionableNavigationBar which has a GlobalKey.

  // Keeping the Hero subtree here is needed (instead of just swapping out the
  // anchor nav bars for fixed size boxes during flights) because the nav bar
  // and their specific component children may serve as anchor points again if
  // another mid-transition flight diversion is triggered.

  // This is ok performance-wise because static nav bars are generally cheap to
  // build and layout but expensive to GPU render (due to clips and blurs) which
  // we're skipping here.
  return Visibility(
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    visible: false, // ModalRoute.of(context)!.isCurrent,
    child: child,
  );
}

/// Navigation bars' hero flight shuttle builder.
Widget navBarHeroFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  assert(fromHeroContext.widget is Hero);
  assert(toHeroContext.widget is Hero);

  final Hero fromHeroWidget = fromHeroContext.widget as Hero;
  final Hero toHeroWidget = toHeroContext.widget as Hero;

  assert(fromHeroWidget.child is TransitionableNavigationBar);
  assert(toHeroWidget.child is TransitionableNavigationBar);

  final TransitionableNavigationBar fromNavBar =
      fromHeroWidget.child as TransitionableNavigationBar;
  final TransitionableNavigationBar toNavBar =
      toHeroWidget.child as TransitionableNavigationBar;

  assert(
    fromNavBar.componentsKeys.navBarBoxKey.currentContext!.owner != null,
    'The from nav bar to Hero must have been mounted in the previous frame',
  );
  assert(
    toNavBar.componentsKeys.navBarBoxKey.currentContext!.owner != null,
    'The to nav bar to Hero must have been mounted in the previous frame',
  );

  switch (flightDirection) {
    case HeroFlightDirection.push:
      return NavigationBarTransition(
        animation: animation,
        bottomNavBar: fromNavBar,
        topNavBar: toNavBar,
      );
    case HeroFlightDirection.pop:
      return NavigationBarTransition(
        animation: animation,
        bottomNavBar: toNavBar,
        topNavBar: fromNavBar,
      );
  }
}
