import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'hero_things.dart';
import 'navigation_bar_static_components.dart';

/// This should always be the first child of Hero widgets.
///
/// This class helps each Hero transition obtain the start or end navigation
/// bar's box size and the inner components of the navigation bar that will
/// move around.
///
/// It should be wrapped around the biggest [RenderBox] of the static
/// navigation bar in each route.
class TransitionableNavigationBar extends StatelessWidget {
  TransitionableNavigationBar({
    required this.componentsKeys,
    required this.backgroundColor,
    required this.backButtonTextStyle,
    required this.titleTextStyle,
    required this.largeTitleTextStyle,
    required this.border,
    required this.hasUserMiddle,
    required this.largeExpanded,
    required this.searchBarHasFocus,
    required this.child,
  })  : assert(!largeExpanded || largeTitleTextStyle != null),
        super(key: componentsKeys.navBarBoxKey);

  final NavigationBarStaticComponentsKeys componentsKeys;
  final Color? backgroundColor;
  final TextStyle backButtonTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle? largeTitleTextStyle;
  final Border? border;
  final bool hasUserMiddle;
  final bool largeExpanded;
  final bool searchBarHasFocus;
  final Widget child;

  RenderBox get renderBox {
    final RenderBox box = componentsKeys.navBarBoxKey.currentContext!
        .findRenderObject()! as RenderBox;
    assert(
      box.attached,
      '_TransitionableNavigationBar.renderBox should be called when building '
      'hero flight shuttles when the from and the to nav bar boxes are already '
      'laid out and painted.',
    );
    return box;
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      bool inHero = false;
      context.visitAncestorElements((Element ancestor) {
        if (ancestor is ComponentElement) {
          assert(
            ancestor.widget.runtimeType != NavigationBarTransition,
            'TransitionableNavigationBar should never re-appear inside '
            'NavigationBarTransition. Keyed TransitionableNavigationBar should '
            'only serve as anchor points in routes rather than appearing inside '
            'Hero flights themselves.',
          );
          if (ancestor.widget.runtimeType == Hero) {
            inHero = true;
          }
        }
        return true;
      });
      assert(
        inHero,
        '_TransitionableNavigationBar should only be added as the immediate '
        'child of Hero widgets.',
      );
      return true;
    }());
    return child;
  }
}

/// This class represents the widget that will be in the Hero flight instead of
/// the 2 static navigation bars by taking inner components from both.
///
/// The `topNavBar` parameter is the nav bar that was on top regardless of
/// push/pop direction.
///
/// Similarly, the `bottomNavBar` parameter is the nav bar that was at the
/// bottom regardless of the push/pop direction.
///
/// If [MediaQuery.padding] is still present in this widget's [BuildContext],
/// that padding will become part of the transitional navigation bar as well.
///
/// [MediaQuery.padding] should be consistent between the from/to routes and
/// the Hero overlay. Inconsistent [MediaQuery.padding] will produce undetermined
/// results.
class NavigationBarTransition extends StatelessWidget {
  NavigationBarTransition({
    super.key,
    required this.animation,
    required this.topNavBar,
    required this.bottomNavBar,
  })  : heightTween = Tween<double>(
          begin: bottomNavBar.renderBox.size.height,
          end: topNavBar.renderBox.size.height,
        ),
        backgroundTween = ColorTween(
          begin: bottomNavBar.backgroundColor,
          end: topNavBar.backgroundColor,
        ),
        borderTween = BorderTween(
          begin: bottomNavBar.border,
          end: topNavBar.border,
        );

  final Animation<double> animation;
  final TransitionableNavigationBar topNavBar;
  final TransitionableNavigationBar bottomNavBar;

  final Tween<double> heightTween;
  final ColorTween backgroundTween;
  final BorderTween borderTween;

  @override
  Widget build(BuildContext context) {
    final _NavigationBarComponentsTransition componentsTransition =
        _NavigationBarComponentsTransition(
      animation: animation,
      bottomNavBar: bottomNavBar,
      topNavBar: topNavBar,
      directionality: Directionality.of(context),
    );

    final List<Widget> children = <Widget>[
      // Draw an empty navigation bar box with changing shape behind all the
      // moving components without any components inside it itself.
      AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return wrapWithBackground(
            // Don't update the system status bar color mid-flight.
            updateSystemUiOverlay: false,
            // backgroundColor: Colors.transparent,
            backgroundColor: backgroundTween.evaluate(animation)!,
            border: borderTween.evaluate(animation),
            child: SizedBox(
              height: heightTween.evaluate(animation),
              width: double.infinity,
            ),
          );
        },
      ),
      // Draw all the components on top of the empty bar box.
      if (componentsTransition.bottomBackChevron != null)
        componentsTransition.bottomBackChevron!,
      if (componentsTransition.bottomBackLabel != null)
        componentsTransition.bottomBackLabel!,
      if (componentsTransition.bottomLeading != null)
        componentsTransition.bottomLeading!,
      if (componentsTransition.bottomMiddle != null)
        componentsTransition.bottomMiddle!,
      if (componentsTransition.bottomLargeTitle != null)
        componentsTransition.bottomLargeTitle!,
      if (componentsTransition.bottomTrailing != null)
        componentsTransition.bottomTrailing!,
      if (componentsTransition.bottomSearchBar != null)
        componentsTransition.bottomSearchBar!,
      if (componentsTransition.bottomLargeTitleActions != null)
        componentsTransition.bottomLargeTitleActions!,
      if (componentsTransition.bottomAppbarBottom != null)
        componentsTransition.bottomAppbarBottom!,
      // Draw top components on top of the bottom components.
      if (componentsTransition.topLeading != null)
        componentsTransition.topLeading!,
      if (componentsTransition.topBackChevron != null)
        componentsTransition.topBackChevron!,
      if (componentsTransition.topBackLabel != null)
        componentsTransition.topBackLabel!,
      if (componentsTransition.topMiddle != null)
        componentsTransition.topMiddle!,
      if (componentsTransition.topTrailing != null)
        componentsTransition.topTrailing!,
      if (componentsTransition.topSearchBar != null)
        componentsTransition.topSearchBar!,
      if (componentsTransition.topLargeTitleActions != null)
        componentsTransition.topLargeTitleActions!,
      if (componentsTransition.topAppbarBottom != null)
        componentsTransition.topAppbarBottom!,
      if (componentsTransition.topLargeTitle != null)
        componentsTransition.topLargeTitle!,
    ];

    // The actual outer box is big enough to contain both the bottom and top
    // navigation bars. It's not a direct Rect lerp because some components
    // can actually be outside the linearly lerp'ed Rect in the middle of
    // the animation, such as the topLargeTitle. The textScaleFactor is kept
    // at 1 to avoid odd transitions between pages.
    return MediaQuery.withNoTextScaling(
      child: SizedBox(
        height: max(heightTween.begin!, heightTween.end!) +
            MediaQuery.paddingOf(context).top,
        width: double.infinity,
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}

/// This class helps create widgets that are in transition based on static
/// components from the bottom and top navigation bars.
///
/// It animates these transitional components both in terms of position and
/// their appearance.
///
/// Instead of running the transitional components through their normal static
/// navigation bar layout logic, this creates transitional widgets that are based
/// on these widgets' existing render objects' layout and position.
///
/// This is possible because this widget is only used during Hero transitions
/// where both the from and to routes are already built and laid out.
///
/// The components' existing layout constraints and positions are then
/// replicated using [Positioned] or [PositionedTransition] wrappers.
///
/// This class should never return [KeyedSubtree]s created by
/// _NavigationBarStaticComponents directly. Since widgets from
/// _NavigationBarStaticComponents are still present in the widget tree during the
/// hero transitions, it would cause global key duplications. Instead, return
/// only the [KeyedSubtree]s' child.
@immutable
class _NavigationBarComponentsTransition {
  _NavigationBarComponentsTransition({
    required this.animation,
    required TransitionableNavigationBar bottomNavBar,
    required TransitionableNavigationBar topNavBar,
    required TextDirection directionality,
  })  : bottomComponents = bottomNavBar.componentsKeys,
        topComponents = topNavBar.componentsKeys,
        bottomNavBarBox = bottomNavBar.renderBox,
        topNavBarBox = topNavBar.renderBox,
        bottomBackButtonTextStyle = bottomNavBar.backButtonTextStyle,
        topBackButtonTextStyle = topNavBar.backButtonTextStyle,
        bottomTitleTextStyle = bottomNavBar.titleTextStyle,
        topTitleTextStyle = topNavBar.titleTextStyle,
        bottomLargeTitleTextStyle = bottomNavBar.largeTitleTextStyle,
        topLargeTitleTextStyle = topNavBar.largeTitleTextStyle,
        bottomHasUserMiddle = bottomNavBar.hasUserMiddle,
        topHasUserMiddle = topNavBar.hasUserMiddle,
        bottomLargeExpanded = bottomNavBar.largeExpanded,
        topLargeExpanded = topNavBar.largeExpanded,
        bottomSearchBarHasFocus = bottomNavBar.searchBarHasFocus,
        topSearchBarHasFocus = topNavBar.searchBarHasFocus,
        transitionBox =
            // paintBounds are based on offset zero so it's ok to expand the Rects.
            bottomNavBar.renderBox.paintBounds
                .expandToInclude(topNavBar.renderBox.paintBounds),
        forwardDirection = directionality == TextDirection.ltr ? 1.0 : -1.0;

  static final Animatable<double> fadeOut = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );
  static final Animatable<double> fadeIn = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );

  final Animation<double> animation;
  final NavigationBarStaticComponentsKeys bottomComponents;
  final NavigationBarStaticComponentsKeys topComponents;

  // These render boxes that are the ancestors of all the bottom and top
  // components are used to determine the components' relative positions inside
  // their respective navigation bars.
  final RenderBox bottomNavBarBox;
  final RenderBox topNavBarBox;

  final TextStyle bottomBackButtonTextStyle;
  final TextStyle topBackButtonTextStyle;
  final TextStyle bottomTitleTextStyle;
  final TextStyle topTitleTextStyle;
  final TextStyle? bottomLargeTitleTextStyle;
  final TextStyle? topLargeTitleTextStyle;

  final bool bottomHasUserMiddle;
  final bool topHasUserMiddle;
  final bool bottomLargeExpanded;
  final bool topLargeExpanded;
  final bool bottomSearchBarHasFocus;
  final bool topSearchBarHasFocus;

  // This is the outer box in which all the components will be fitted. The
  // sizing component of RelativeRects will be based on this rect's size.
  final Rect transitionBox;

  // x-axis unity number representing the direction of growth for text.
  final double forwardDirection;

  // Take a widget it its original ancestor navigation bar render box and
  // translate it into a RelativeBox in the transition navigation bar box.
  RelativeRect positionInTransitionBox(
    GlobalKey key, {
    required RenderBox from,
  }) {
    final RenderBox componentBox =
        key.currentContext!.findRenderObject()! as RenderBox;
    assert(componentBox.attached);

    return RelativeRect.fromRect(
      componentBox.localToGlobal(Offset.zero, ancestor: from) &
          componentBox.size,
      transitionBox,
    );
  }

  // Create an animated widget that moves the given child widget between its
  // original position in its ancestor navigation bar to another widget's
  // position in that widget's navigation bar.
  //
  // Anchor their positions based on the vertical middle of their respective
  // render boxes' leading edge.
  //
  // This method assumes there's no other transforms other than translations
  // when converting a rect from the original navigation bar's coordinate space
  // to the other navigation bar's coordinate space, to avoid performing
  // floating point operations on the size of the child widget, so that the
  // incoming constraints used for sizing the child widget will be exactly the
  // same.
  FixedSizeSlidingTransition slideFromLeadingEdge({
    required GlobalKey fromKey,
    required RenderBox fromNavBarBox,
    required GlobalKey toKey,
    required RenderBox toNavBarBox,
    required Widget child,
  }) {
    final RenderBox fromBox =
        fromKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox toBox =
        toKey.currentContext!.findRenderObject()! as RenderBox;

    final bool isLTR = forwardDirection > 0;

    // The animation moves the fromBox so its anchor (left-center or right-center
    // depending on the writing direction) aligns with toBox's anchor.
    final Offset fromAnchorLocal = Offset(
      isLTR ? 0 : fromBox.size.width,
      fromBox.size.height / 2,
    );
    final Offset toAnchorLocal = Offset(
      isLTR ? 0 : toBox.size.width,
      toBox.size.height / 2,
    );
    final Offset fromAnchorInFromBox =
        fromBox.localToGlobal(fromAnchorLocal, ancestor: fromNavBarBox);
    final Offset toAnchorInToBox =
        toBox.localToGlobal(toAnchorLocal, ancestor: toNavBarBox);

    // We can't get ahold of the render box of the stack (i.e., `transitionBox`)
    // we place components on yet, but we know the stack needs to be top-leading
    // aligned with both fromNavBarBox and toNavBarBox to make the transition
    // look smooth. Also use the top-leading point as the origin for ease of
    // calculation.

    // The offset to move fromAnchor to toAnchor, in transitionBox's top-leading
    // coordinates.
    final Offset translation = isLTR
        ? toAnchorInToBox - fromAnchorInFromBox
        : Offset(toNavBarBox.size.width - toAnchorInToBox.dx,
                toAnchorInToBox.dy) -
            Offset(fromNavBarBox.size.width - fromAnchorInFromBox.dx,
                fromAnchorInFromBox.dy);

    final RelativeRect fromBoxMargin =
        positionInTransitionBox(fromKey, from: fromNavBarBox);
    final Offset fromOriginInTransitionBox = Offset(
      isLTR ? fromBoxMargin.left : fromBoxMargin.right,
      fromBoxMargin.top,
    );

    final Tween<Offset> anchorMovementInTransitionBox = Tween<Offset>(
      begin: fromOriginInTransitionBox,
      end: fromOriginInTransitionBox + translation,
    );

    return FixedSizeSlidingTransition(
      isLTR: isLTR,
      offsetAnimation: animation.drive(anchorMovementInTransitionBox),
      size: fromBox.size,
      child: child,
    );
  }

  Animation<double> fadeInFrom(double t, {Curve curve = Curves.easeIn}) {
    return animation.drive(fadeIn.chain(
      CurveTween(curve: Interval(t, 1.0, curve: curve)),
    ));
  }

  Animation<double> fadeOutBy(double t, {Curve curve = Curves.easeOut}) {
    return animation.drive(fadeOut.chain(
      CurveTween(curve: Interval(0.0, t, curve: curve)),
    ));
  }

  Widget? get bottomLeading {
    final KeyedSubtree? bottomLeading =
        bottomComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomLeading == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(bottomComponents.leadingKey,
          from: bottomNavBarBox),
      child: FadeTransition(
        opacity: fadeOutBy(0.4),
        child: Material(color: Colors.transparent, child: bottomLeading.child),
      ),
    );
  }

  Widget? get topLeading {
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (topLeading == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect:
          positionInTransitionBox(topComponents.leadingKey, from: topNavBarBox),
      child: FadeTransition(
        opacity: fadeInFrom(0.6),
        child: Material(
          color: Colors.transparent,
          child: topLeading.child,
        ),
      ),
    );
  }

  Widget? get bottomBackChevron {
    final KeyedSubtree? bottomBackChevron =
        bottomComponents.backChevronKey.currentWidget as KeyedSubtree?;

    if (bottomBackChevron == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(bottomComponents.backChevronKey,
          from: bottomNavBarBox),
      child: FadeTransition(
        opacity: fadeOutBy(0.6),
        child: DefaultTextStyle(
          style: bottomBackButtonTextStyle,
          child: bottomBackChevron.child,
        ),
      ),
    );
  }

  Widget? get topBackChevron {
    final KeyedSubtree? topBackChevron =
        topComponents.backChevronKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? bottomBackChevron =
        bottomComponents.backChevronKey.currentWidget as KeyedSubtree?;

    if (topBackChevron == null) {
      return null;
    }

    final RelativeRect to = positionInTransitionBox(
        topComponents.backChevronKey,
        from: topNavBarBox);
    RelativeRect from = to;

    // If it's the first page with a back chevron, shift in slightly from the
    // right.
    if (bottomBackChevron == null) {
      final RenderBox topBackChevronBox =
          topComponents.backChevronKey.currentContext!.findRenderObject()!
              as RenderBox;
      from = to.shift(
        Offset(
          forwardDirection * topBackChevronBox.size.width * 2.0,
          0.0,
        ),
      );
    }

    final RelativeRectTween positionTween = RelativeRectTween(
      begin: from,
      end: to,
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeInFrom(bottomBackChevron == null ? 0.7 : 0.4),
        child: DefaultTextStyle(
          style: topBackButtonTextStyle,
          child: topBackChevron.child,
        ),
      ),
    );
  }

  Widget? get bottomBackLabel {
    final KeyedSubtree? bottomBackLabel =
        bottomComponents.backLabelKey.currentWidget as KeyedSubtree?;

    if (bottomBackLabel == null) {
      return null;
    }

    final RelativeRect from = positionInTransitionBox(
        bottomComponents.backLabelKey,
        from: bottomNavBarBox);

    // Transition away by sliding horizontally to the leading edge off of the screen.
    final RelativeRectTween positionTween = RelativeRectTween(
      begin: from,
      end: from.shift(
        Offset(
          forwardDirection * (-bottomNavBarBox.size.width / 2.0),
          0.0,
        ),
      ),
    );

    return PositionedTransition(
      rect: animation.drive(positionTween),
      child: FadeTransition(
        opacity: fadeOutBy(0.2),
        child: DefaultTextStyle(
          style: bottomBackButtonTextStyle,
          child: bottomBackLabel.child,
        ),
      ),
    );
  }

  Widget? get topBackLabel {
    final KeyedSubtree? bottomMiddle =
        bottomComponents.middleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? bottomLargeTitle =
        bottomComponents.largeTitleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;

    if (topBackLabel == null) {
      return null;
    }

    final RenderAnimatedOpacity? topBackLabelOpacity = topComponents
        .backLabelKey.currentContext
        ?.findAncestorRenderObjectOfType<RenderAnimatedOpacity>();

    Animation<double>? midClickOpacity;
    if (topBackLabelOpacity != null &&
        topBackLabelOpacity.opacity.value < 1.0) {
      midClickOpacity = animation.drive(Tween<double>(
        begin: 0.0,
        end: topBackLabelOpacity.opacity.value,
      ));
    }

    // Pick up from an incoming transition from the large title. This is
    // duplicated here from the bottomLargeTitle transition widget because the
    // content text might be different. For instance, if the bottomLargeTitle
    // text is too long, the topBackLabel will say 'Back' instead of the original
    // text.
    if (bottomLargeTitle != null && bottomLargeExpanded) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.largeTitleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: midClickOpacity ?? fadeInFrom(0.4),
          child: DefaultTextStyleTransition(
            style: animation.drive(TextStyleTween(
              begin: bottomLargeTitleTextStyle,
              end: topBackButtonTextStyle,
            )),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: topBackLabel.child,
          ),
        ),
      );
    }

    // The topBackLabel always comes from the large title first if available
    // and expanded instead of middle.
    if (bottomMiddle != null) {
      return slideFromLeadingEdge(
        fromKey: bottomComponents.middleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: midClickOpacity ?? fadeInFrom(0.3),
          child: DefaultTextStyleTransition(
            style: animation.drive(TextStyleTween(
              begin: bottomTitleTextStyle,
              end: topBackButtonTextStyle,
            )),
            child: topBackLabel.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get bottomMiddle {
    final KeyedSubtree? bottomMiddle =
        bottomComponents.middleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    // The middle component is non-null when the nav bar is a large title
    // nav bar but would be invisible when expanded, therefore don't show it here.
    if (bottomSearchBarHasFocus) {
      return null;
    }

    if (!bottomHasUserMiddle && bottomLargeExpanded) {
      return null;
    }

    if (bottomMiddle != null && topBackLabel != null) {
      // Move from current position to the top page's back label position.
      return slideFromLeadingEdge(
        fromKey: bottomComponents.middleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          // A custom middle widget like a segmented control fades away faster.
          opacity: fadeOutBy(bottomHasUserMiddle ? 0.4 : 0.7),
          child: Align(
            // As the text shrinks, make sure it's still anchored to the leading
            // edge of a constantly sized outer box.
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyleTransition(
              style: animation.drive(TextStyleTween(
                begin: bottomTitleTextStyle,
                end: topBackButtonTextStyle,
              )),
              child: bottomMiddle.child,
            ),
          ),
        ),
      );
    }

    // When the top page has a leading widget override (one of the few ways to
    // not have a top back label), don't move the bottom middle widget and just
    // fade.
    if (bottomMiddle != null && topLeading != null) {
      return Positioned.fromRelativeRect(
        rect: positionInTransitionBox(bottomComponents.middleKey,
            from: bottomNavBarBox),
        child: FadeTransition(
          opacity: fadeOutBy(bottomHasUserMiddle ? 0.4 : 0.7),
          // Keep the font when transitioning into a non-back label leading.
          child: DefaultTextStyle(
            style: bottomTitleTextStyle,
            child: bottomMiddle.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get topMiddle {
    final KeyedSubtree? topMiddle =
        topComponents.middleKey.currentWidget as KeyedSubtree?;

    if (topMiddle == null) {
      return null;
    }

    // The middle component is non-null when the nav bar is a large title
    // nav bar but would be invisible when expanded, therefore don't show it here.
    if (!topHasUserMiddle && topLargeExpanded) {
      return null;
    }

    final RelativeRect to =
        positionInTransitionBox(topComponents.middleKey, from: topNavBarBox);
    final RenderBox toBox = topComponents.middleKey.currentContext!
        .findRenderObject()! as RenderBox;

    final bool isLTR = forwardDirection > 0;

    // Anchor is the top-leading point of toBox, in transition box's top-leading
    // coordinate space.
    final Offset toAnchorInTransitionBox = Offset(
      isLTR ? to.left : to.right,
      to.top,
    );

    // Shift in from the trailing edge of the screen.
    final Tween<Offset> anchorMovementInTransitionBox = Tween<Offset>(
      begin: Offset(
        // the "width / 2" here makes the middle widget's horizontal center on
        // the trailing edge of the top nav bar.
        topNavBarBox.size.width - toBox.size.width / 2,
        to.top,
      ),
      end: toAnchorInTransitionBox,
    );

    return FixedSizeSlidingTransition(
      isLTR: isLTR,
      offsetAnimation: animation.drive(anchorMovementInTransitionBox),
      size: toBox.size,
      child: FadeTransition(
        opacity: fadeInFrom(0.25),
        child: DefaultTextStyle(
          style: topTitleTextStyle,
          child: topMiddle.child,
        ),
      ),
    );
  }

  Widget? get bottomLargeTitle {
    final KeyedSubtree? bottomLargeTitle =
        bottomComponents.largeTitleKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomLargeTitle == null || !bottomLargeExpanded) {
      return null;
    }

    if (topBackLabel != null) {
      // Move from current position to the top page's back label position.
      return slideFromLeadingEdge(
        fromKey: bottomComponents.largeTitleKey,
        fromNavBarBox: bottomNavBarBox,
        toKey: topComponents.backLabelKey,
        toNavBarBox: topNavBarBox,
        child: FadeTransition(
          opacity: fadeOutBy(0.6),
          child: Align(
            // As the text shrinks, make sure it's still anchored to the leading
            // edge of a constantly sized outer box.
            alignment: AlignmentDirectional.centerStart,
            child: DefaultTextStyleTransition(
              style: animation.drive(TextStyleTween(
                begin: bottomLargeTitleTextStyle,
                end: topBackButtonTextStyle,
              )),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: bottomLargeTitle.child,
            ),
          ),
        ),
      );
    }

    if (topLeading != null) {
      // Unlike bottom middle, the bottom large title moves when it can't
      // transition to the top back label position.
      final RelativeRect from = positionInTransitionBox(
          bottomComponents.largeTitleKey,
          from: bottomNavBarBox);

      final RelativeRectTween positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(
            forwardDirection * bottomNavBarBox.size.width / 4.0,
            0.0,
          ),
        ),
      );

      // Just shift slightly towards the trailing edge instead of moving to the
      // back label position.
      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.4),
          // Keep the font when transitioning into a non-back-label leading.
          child: DefaultTextStyle(
            style: bottomLargeTitleTextStyle!,
            child: bottomLargeTitle.child,
          ),
        ),
      );
    }

    return null;
  }

  Widget? get topLargeTitle {
    final KeyedSubtree? topLargeTitle =
        topComponents.largeTitleKey.currentWidget as KeyedSubtree?;

    if (topLargeTitle == null || !topLargeExpanded) {
      return null;
    }

    final RelativeRect to = positionInTransitionBox(topComponents.largeTitleKey,
        from: topNavBarBox);

    // Shift in from the trailing edge of the screen.
    final dynamic positionTween = RelativeRectTween(
      begin: to.shift(
        Offset(
          forwardDirection * topNavBarBox.size.width,
          0.0,
        ),
      ),
      end: to,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: custom,
        reverseCurve: custom,
      ),
    );

    return PositionedTransition(
      rect: positionTween,
      child: DefaultTextStyle(
        style: topLargeTitleTextStyle!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        child: topLargeTitle.child,
      ),
    );
  }

  Widget? get bottomTrailing {
    final KeyedSubtree? bottomTrailing =
        bottomComponents.trailingKey.currentWidget as KeyedSubtree?;

    if (bottomTrailing == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(bottomComponents.trailingKey,
          from: bottomNavBarBox),
      child: FadeTransition(
        opacity: fadeOutBy(0.6),
        child: bottomTrailing.child,
      ),
    );
  }

  Widget? get topTrailing {
    final KeyedSubtree? topTrailing =
        topComponents.trailingKey.currentWidget as KeyedSubtree?;

    if (topTrailing == null) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(topComponents.trailingKey,
          from: topNavBarBox),
      child: FadeTransition(
        opacity: fadeInFrom(0.4),
        child: topTrailing.child,
      ),
    );
  }

  Widget? get bottomSearchBar {
    final KeyedSubtree? bottomSearchBar =
        bottomComponents.searchBarKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topBackLabel =
        topComponents.backLabelKey.currentWidget as KeyedSubtree?;
    final KeyedSubtree? topLeading =
        topComponents.leadingKey.currentWidget as KeyedSubtree?;

    if (bottomSearchBar == null || !bottomLargeExpanded) {
      return null;
    }

    if (topLeading != null || topBackLabel != null) {
      // Unlike bottom middle, the bottom large title moves when it can't
      // transition to the top back label position.
      final RelativeRect from = positionInTransitionBox(
          bottomComponents.searchBarKey,
          from: bottomNavBarBox);

      final RelativeRectTween positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(
            -4.65 * forwardDirection * bottomNavBarBox.size.width,
            0.0,
          ),
        ),
      );

      // Just shift slightly towards the trailing edge instead of moving to the
      // back label position.
      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.1),
          child: bottomSearchBar.child,
        ),
      );
    }

    return null;
  }

  Widget? get topSearchBar {
    final KeyedSubtree? topSearchBar =
        topComponents.searchBarKey.currentWidget as KeyedSubtree?;

    if (topSearchBar == null) {
      return null;
    }

    final RelativeRect to =
        positionInTransitionBox(topComponents.searchBarKey, from: topNavBarBox);

    // Shift in from the trailing edge of the screen.
    final dynamic positionTween = RelativeRectTween(
      begin: to.shift(
        Offset(
          forwardDirection * topNavBarBox.size.width,
          0.0,
        ),
      ),
      end: to,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: custom,
        reverseCurve: custom,
      ),
    );

    return PositionedTransition(
      rect: positionTween,
      child: topSearchBar.child,
    );
  }

  Widget? get bottomLargeTitleActions {
    final KeyedSubtree? bottomLargeTitleActions =
        bottomComponents.largeTitleActionsKey.currentWidget as KeyedSubtree?;

    if (bottomLargeTitleActions == null) {
      return null;
    }

    if (!bottomLargeExpanded) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(bottomComponents.largeTitleActionsKey,
          from: bottomNavBarBox),
      child: FadeTransition(
        opacity: fadeOutBy(0.4),
        child: bottomLargeTitleActions.child,
      ),
    );
  }

  Widget? get topLargeTitleActions {
    final KeyedSubtree? topLargeTitleActions =
        topComponents.largeTitleActionsKey.currentWidget as KeyedSubtree?;

    if (topLargeTitleActions == null) {
      return null;
    }

    if (!topLargeExpanded) {
      return null;
    }

    return Positioned.fromRelativeRect(
      rect: positionInTransitionBox(topComponents.largeTitleActionsKey,
          from: topNavBarBox),
      child: FadeTransition(
        opacity: fadeInFrom(0.6),
        child: topLargeTitleActions.child,
      ),
    );
  }

  Widget? get bottomAppbarBottom {
    final KeyedSubtree? bottomAppbarBottom =
        bottomComponents.appbarBottomKey.currentWidget as KeyedSubtree?;

    if (bottomAppbarBottom == null) {
      return null;
    }

    if (topLeading != null || topBackLabel != null) {
      // Unlike bottom middle, the bottom large title moves when it can't
      // transition to the top back label position.
      final RelativeRect from = positionInTransitionBox(
          bottomComponents.appbarBottomKey,
          from: bottomNavBarBox);

      final RelativeRectTween positionTween = RelativeRectTween(
        begin: from,
        end: from.shift(
          Offset(
            -4.65 * forwardDirection * bottomNavBarBox.size.width,
            0.0,
          ),
        ),
      );

      // Just shift slightly towards the trailing edge instead of moving to the
      // back label position.
      return PositionedTransition(
        rect: animation.drive(positionTween),
        child: FadeTransition(
          opacity: fadeOutBy(0.7),
          child: Material(
              color: Colors.transparent, child: bottomAppbarBottom.child),
        ),
      );
    }

    return null;
  }

  Widget? get topAppbarBottom {
    final KeyedSubtree? topAppbarBottom =
        topComponents.appbarBottomKey.currentWidget as KeyedSubtree?;

    if (topAppbarBottom == null) {
      return null;
    }

    final RelativeRect to = positionInTransitionBox(
        topComponents.appbarBottomKey,
        from: topNavBarBox);

    // Shift in from the trailing edge of the screen.
    final dynamic positionTween = RelativeRectTween(
      begin: to.shift(
        Offset(
          forwardDirection * topNavBarBox.size.width,
          0.0,
        ),
      ),
      end: to,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: custom,
        reverseCurve: custom,
      ),
    );

    return PositionedTransition(
      rect: positionTween,
      child: Material(color: Colors.transparent, child: topAppbarBottom.child),
    );
  }
}

// Curve get custom => const Cubic(.83, .19, .67, .56);
Curve get custom => const Cubic(.83, .19, .67, .56);

// An `AnimatedWidget` that imposes a fixed size on its child widget, and
// shifts the child widget in the parent stack, driven by its `offsetAnimation`
// property.
class FixedSizeSlidingTransition extends AnimatedWidget {
  const FixedSizeSlidingTransition({
    super.key,
    required this.isLTR,
    required this.offsetAnimation,
    required this.size,
    required this.child,
  }) : super(listenable: offsetAnimation);

  // Whether the writing direction used in the navigation bar transition is
  // left-to-right.
  final bool isLTR;

  // The fixed size to impose on `child`.
  final Size size;

  // The animated offset from the top-leading corner of the stack.
  //
  // When `isLTR` is true, the `Offset` is the position of the child widget in
  // the stack render box's regular coordinate space.
  //
  // When `isLTR` is false, the coordinate system is flipped around the
  // horizontal axis and the origin is set to the top right corner of the render
  // boxes. In other words, this parameter describes the offset from the top
  // right corner of the stack, to the top right corner of the child widget, and
  // the x-axis runs right to left.
  final Animation<Offset> offsetAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offsetAnimation.value.dy,
      left: isLTR ? offsetAnimation.value.dx : null,
      right: isLTR ? null : offsetAnimation.value.dx,
      width: size.width,
      height: size.height,
      child: child,
    );
  }
}
