import 'package:flutter/cupertino.dart';
import 'package:super_cupertino_navigation_bar/src/shared/measures.dart';
import 'package:super_cupertino_navigation_bar/src/shared/navigation_bar_static_components.dart';
import 'package:super_cupertino_navigation_bar/src/shared/persistent_navigation_bar.dart';
import 'package:super_cupertino_navigation_bar/src/shared/transitionable_navigation_bar.dart';

/// An iOS-styled navigation bar.
///
/// The navigation bar is a toolbar that minimally consists of a widget, normally
/// a page title, in the [middle] of the toolbar.
///
/// It also supports a [leading] and [trailing] widget before and after the
/// [middle] widget while keeping the [middle] widget centered.
///
/// The [leading] widget will automatically be a back chevron icon button (or a
/// close button in case of a fullscreen dialog) to pop the current route if none
/// is provided and [automaticallyImplyLeading] is true (true by default).
///
/// The [middle] widget will automatically be a title text from the current
/// [CupertinoPageRoute] if none is provided and [automaticallyImplyMiddle] is
/// true (true by default).
///
/// It should be placed at top of the screen and automatically accounts for
/// the OS's status bar.
///
/// If the given [backgroundColor]'s opacity is not 1.0 (which is the case by
/// default), it will produce a blurring effect to the content behind it.
///
/// When [transitionBetweenRoutes] is true, this navigation bar will transition
/// on top of the routes instead of inside them if the route being transitioned
/// to also has a [DefaultCupertinoNavigationBar] or a [CupertinoSliverNavigationBar]
/// with [transitionBetweenRoutes] set to true. If [transitionBetweenRoutes] is
/// true, none of the [Widget] parameters can contain a key in its subtree since
/// that widget will exist in multiple places in the tree simultaneously.
///
/// By default, only one [DefaultCupertinoNavigationBar] or [CupertinoSliverNavigationBar]
/// should be present in each [PageRoute] to support the default transitions.
/// Use [transitionBetweenRoutes] or [heroTag] to customize the transition
/// behavior for multiple navigation bars per route.
///
/// When used in a [CupertinoPageScaffold], [CupertinoPageScaffold.navigationBar]
/// has its text scale factor set to 1.0 and does not respond to text scale factor
/// changes from the operating system, to match the native iOS behavior. To override
/// this behavior, wrap each of the `navigationBar`'s components inside a [MediaQuery]
/// with the desired [MediaQueryData.textScaleFactor] value. The text scale factor
/// value from the operating system can be retrieved in many ways, such as querying
/// [MediaQuery.textScaleFactorOf] against [CupertinoApp]'s [BuildContext].
///
/// {@tool dartpad}
/// This example shows a [DefaultCupertinoNavigationBar] placed in a [CupertinoPageScaffold].
/// Since [backgroundColor]'s opacity is not 1.0, there is a blur effect and
/// content slides underneath.
///
/// ** See code in examples/api/lib/cupertino/nav_bar/cupertino_navigation_bar.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CupertinoPageScaffold], a page layout helper typically hosting the
///    [DefaultCupertinoNavigationBar].
///  * [CupertinoSliverNavigationBar] for a navigation bar to be placed in a
///    scrolling list and that supports iOS-11-style large titles.
///  * <https://developer.apple.com/design/human-interface-guidelines/ios/bars/navigation-bars/>
class DefaultCupertinoNavigationBar extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  /// Creates a navigation bar in the iOS style.
  const DefaultCupertinoNavigationBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.previousPageTitle,
    this.middle,
    this.trailing,
    this.border = Measures.kDefaultNavBarBorder,
    this.backgroundColor,
    this.brightness,
    this.padding,
    this.transitionBetweenRoutes = true,
    this.heroTag = Measures.defaultHeroTag,
  }) : assert(
          !transitionBetweenRoutes ||
              identical(heroTag, Measures.defaultHeroTag),
          'Cannot specify a heroTag override if this navigation bar does not '
          'transition due to transitionBetweenRoutes = false.',
        );

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.leading}
  /// Widget to place at the start of the navigation bar. Normally a back button
  /// for a normal page or a cancel button for full page dialogs.
  ///
  /// If null and [automaticallyImplyLeading] is true, an appropriate button
  /// will be automatically created.
  /// {@endtemplate}
  final Widget? leading;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.automaticallyImplyLeading}
  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the [leading]
  /// widget should be. If [leading] widget is not null, this parameter has no effect.
  ///
  /// Specifically this navigation bar will:
  ///
  /// 1. Show a 'Close' button if the current route is a `fullscreenDialog`.
  /// 2. Show a back chevron with [previousPageTitle] if [previousPageTitle] is
  ///    not null.
  /// 3. Show a back chevron with the previous route's `title` if the current
  ///    route is a [CupertinoPageRoute] and the previous route is also a
  ///    [CupertinoPageRoute].
  ///
  /// This value cannot be null.
  /// {@endtemplate}
  final bool automaticallyImplyLeading;

  /// Controls whether we should try to imply the middle widget if null.
  ///
  /// If true and [middle] is null, automatically fill in a [Text] widget with
  /// the current route's `title` if the route is a [CupertinoPageRoute].
  /// If [middle] widget is not null, this parameter has no effect.
  ///
  /// This value cannot be null.
  final bool automaticallyImplyMiddle;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.previousPageTitle}
  /// Manually specify the previous route's title when automatically implying
  /// the leading back button.
  ///
  /// Overrides the text shown with the back chevron instead of automatically
  /// showing the previous [CupertinoPageRoute]'s `title` when
  /// [automaticallyImplyLeading] is true.
  ///
  /// Has no effect when [leading] is not null or if [automaticallyImplyLeading]
  /// is false.
  /// {@endtemplate}
  final String? previousPageTitle;

  /// Widget to place in the middle of the navigation bar. Normally a title or
  /// a segmented control.
  ///
  /// If null and [automaticallyImplyMiddle] is true, an appropriate [Text]
  /// title will be created if the current route is a [CupertinoPageRoute] and
  /// has a `title`.
  final Widget? middle;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.trailing}
  /// Widget to place at the end of the navigation bar. Normally additional actions
  /// taken on the page such as a search or edit function.
  /// {@endtemplate}
  final Widget? trailing;

  // TODO(xster): https://github.com/flutter/flutter/issues/10469 implement
  // support for double row navigation bars.

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.backgroundColor}
  /// The background color of the navigation bar. If it contains transparency, the
  /// tab bar will automatically produce a blurring effect to the content
  /// behind it.
  ///
  /// Defaults to [CupertinoTheme]'s `barBackgroundColor` if null.
  /// {@endtemplate}
  final Color? backgroundColor;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.brightness}
  /// The brightness of the specified [backgroundColor].
  ///
  /// Setting this value changes the style of the system status bar. Typically
  /// used to increase the contrast ratio of the system status bar over
  /// [backgroundColor].
  ///
  /// If set to null, the value of the property will be inferred from the relative
  /// luminance of [backgroundColor].
  /// {@endtemplate}
  final Brightness? brightness;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.padding}
  /// Padding for the contents of the navigation bar.
  ///
  /// If null, the navigation bar will adopt the following defaults:
  ///
  ///  * Vertically, contents will be sized to the same height as the navigation
  ///    bar itself minus the status bar.
  ///  * Horizontally, padding will be 16 pixels according to iOS specifications
  ///    unless the leading widget is an automatically inserted back button, in
  ///    which case the padding will be 0.
  ///
  /// Vertical padding won't change the height of the nav bar.
  /// {@endtemplate}
  final EdgeInsetsDirectional? padding;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.border}
  /// The border of the navigation bar. By default renders a single pixel bottom border side.
  ///
  /// If a border is null, the navigation bar will not display a border.
  /// {@endtemplate}
  final Border? border;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.transitionBetweenRoutes}
  /// Whether to transition between navigation bars.
  ///
  /// When [transitionBetweenRoutes] is true, this navigation bar will transition
  /// on top of the routes instead of inside it if the route being transitioned
  /// to also has a [DefaultCupertinoNavigationBar] or a [CupertinoSliverNavigationBar]
  /// with [transitionBetweenRoutes] set to true.
  ///
  /// This transition will also occur on edge back swipe gestures like on iOS
  /// but only if the previous page below has `maintainState` set to true on the
  /// [PageRoute].
  ///
  /// When set to true, only one navigation bar can be present per route unless
  /// [heroTag] is also set.
  ///
  /// This value defaults to true and cannot be null.
  /// {@endtemplate}
  final bool transitionBetweenRoutes;

  /// {@template flutter.cupertino.ExtendedCupertinoNavigationBar.heroTag}
  /// Tag for the navigation bar's Hero widget if [transitionBetweenRoutes] is true.
  ///
  /// Defaults to a common tag between all [DefaultCupertinoNavigationBar] and
  /// [CupertinoSliverNavigationBar] instances of the same [Navigator]. With the
  /// default tag, all navigation bars of the same navigator can transition
  /// between each other as long as there's only one navigation bar per route.
  ///
  /// This [heroTag] can be overridden to manually handle having multiple
  /// navigation bars per route or to transition between multiple
  /// [Navigator]s.
  ///
  /// Cannot be null. To disable Hero transitions for this navigation bar,
  /// set [transitionBetweenRoutes] to false.
  /// {@endtemplate}
  final Object heroTag;

  /// True if the navigation bar's background color has no transparency.
  @override
  bool shouldFullyObstruct(BuildContext context) {
    final Color backgroundColor =
        CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ??
            CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF;
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(Measures.navBarPersistentHeight);
  }

  @override
  State<DefaultCupertinoNavigationBar> createState() =>
      _DefaultCupertinoNavigationBarState();
}

// A state class exists for the nav bar so that the keys of its sub-components
// don't change when rebuilding the nav bar, causing the sub-components to
// lose their own states.
class _DefaultCupertinoNavigationBarState
    extends State<DefaultCupertinoNavigationBar> {
  late NavigationBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = NavigationBarStaticComponentsKeys();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        CupertinoDynamicColor.maybeResolve(widget.backgroundColor, context) ??
            CupertinoTheme.of(context).scaffoldBackgroundColor;

    final NavigationBarStaticComponents components =
        NavigationBarStaticComponents(
      keys: keys,
      route: ModalRoute.of(context),
      userLeading: widget.leading,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      automaticallyImplyTitle: widget.automaticallyImplyMiddle,
      previousPageTitle: widget.previousPageTitle,
      userMiddle: widget.middle,
      userTrailing: widget.trailing,
      padding: widget.padding,
      userLargeTitle: null,
      large: false,
    );

    final Widget navBar = wrapWithBackground(
      border: widget.border,
      backgroundColor: backgroundColor,
      brightness: widget.brightness,
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: PersistentNavigationBar(
          components: components,
          padding: widget.padding,
        ),
      ),
    );

    if (!widget.transitionBetweenRoutes || !isTransitionable(context)) {
      // Lint ignore to maintain backward compatibility.
      return navBar;
    }

    return Builder(
      // Get the context that might have a possibly changed CupertinoTheme.
      builder: (BuildContext context) {
        return Hero(
          tag: widget.heroTag == Measures.defaultHeroTag
              ? HeroTag(Navigator.of(context))
              : widget.heroTag,
          createRectTween: linearTranslateWithLargestRectSizeTween,
          placeholderBuilder: navBarHeroLaunchPadBuilder,
          flightShuttleBuilder: navBarHeroFlightShuttleBuilder,
          transitionOnUserGestures: true,
          child: TransitionableNavigationBar(
            componentsKeys: keys,
            backgroundColor: backgroundColor,
            backButtonTextStyle:
                CupertinoTheme.of(context).textTheme.navActionTextStyle,
            titleTextStyle:
                CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            largeTitleTextStyle: null,
            border: widget.border,
            hasUserMiddle: widget.middle != null,
            largeExpanded: false,
            searchBarHasFocus: false,
            child: navBar,
          ),
        );
      },
    );
  }
}
