import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';
import 'package:super_cupertino_navigation_bar/models/super_appbar.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar_action.model.dart';
import 'package:super_cupertino_navigation_bar/models/will_pop.dart';
import 'package:super_cupertino_navigation_bar/utils/hero_tag.dart';
import 'package:super_cupertino_navigation_bar/utils/hero_things.dart';
import 'package:super_cupertino_navigation_bar/utils/measures.dart';
import 'package:super_cupertino_navigation_bar/utils/navigation_bar_static_components.dart';
import 'package:super_cupertino_navigation_bar/utils/persistent_nav_bar.dart';
import 'package:super_cupertino_navigation_bar/utils/store.dart';
import 'package:super_cupertino_navigation_bar/utils/transitionable_navigation_bar.dart';

class SuperScaffold extends StatefulWidget {
  SuperScaffold({
    Key? key,
    this.appBar,
    this.stretch = true,
    this.body = const SizedBox(),
    this.floatingActionButton,
    this.onCollapsed,
    this.brightness,

    // Scaffold attr
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.scrollController,
    this.transitionBetweenRoutes = true,
    this.backgroundColor,
  }) : super(key: key) {
    appBar = appBar ?? SuperAppBar();

    measures = Measures(
      searchTextFieldHeight: appBar!.searchBar!.height,
      largeTitleContainerHeight: appBar!.largeTitle!.height,
      primaryToolbarHeight: appBar!.height,
      bottomToolbarHeight: appBar!.bottom!.height,
      searchBarAnimationDurationx: appBar!.searchBar!.animationDuration,
    );
  }

  final FloatingActionButton? floatingActionButton;
  final bool stretch;
  final bool transitionBetweenRoutes;
  late final Measures measures;
  SuperAppBar? appBar;
  final Widget body;
  final Function(bool)? onCollapsed;
  final Color? backgroundColor;
  ScrollController? scrollController;
  final Brightness? brightness;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location, [FloatingActionButtonLocation.endFloat].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move the [floatingActionButton] to a new [floatingActionButtonLocation].
  ///
  /// If null, the [ScaffoldState] will use the default animator, [FloatingActionButtonAnimator.scaling].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A set of buttons that are displayed at the bottom of the scaffold.
  ///
  /// Typically this is a list of [TextButton] widgets. These buttons are
  /// persistently visible, even if the [body] of the scaffold scrolls.
  ///
  /// These widgets will be wrapped in an [OverflowBar].
  ///
  /// The [persistentFooterButtons] are rendered above the
  /// [bottomNavigationBar] but below the [body].
  final List<Widget>? persistentFooterButtons;

  /// The alignment of the [persistentFooterButtons] inside the [OverflowBar].
  ///
  /// Defaults to [AlignmentDirectional.centerEnd].
  final AlignmentDirectional persistentFooterAlignment;

  /// A panel displayed to the side of the [body], often hidden on mobile
  /// devices. Swipes in from either left-to-right ([TextDirection.ltr]) or
  /// right-to-left ([TextDirection.rtl])
  ///
  /// Typically a [Drawer].
  ///
  /// To open the drawer, use the [ScaffoldState.openDrawer] function.
  ///
  /// To close the drawer, use either [ScaffoldState.closeDrawer], [Navigator.pop]
  /// or press the escape key on the keyboard.
  ///
  /// {@tool dartpad}
  /// To disable the drawer edge swipe on mobile, set the
  /// [Scaffold.drawerEnableOpenDragGesture] to false. Then, use
  /// [ScaffoldState.openDrawer] to open the drawer and [Navigator.pop] to close
  /// it.
  ///
  /// ** See code in examples/api/lib/material/scaffold/scaffold.drawer.0.dart **
  /// {@end-tool}
  final Widget? drawer;

  /// Optional callback that is called when the [Scaffold.drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed to the side of the [body], often hidden on mobile
  /// devices. Swipes in from right-to-left ([TextDirection.ltr]) or
  /// left-to-right ([TextDirection.rtl])
  ///
  /// Typically a [Drawer].
  ///
  /// To open the drawer, use the [ScaffoldState.openEndDrawer] function.
  ///
  /// To close the drawer, use either [ScaffoldState.closeEndDrawer], [Navigator.pop]
  /// or press the escape key on the keyboard.
  ///
  /// {@tool dartpad}
  /// To disable the drawer edge swipe, set the
  /// [Scaffold.endDrawerEnableOpenDragGesture] to false. Then, use
  /// [ScaffoldState.openEndDrawer] to open the drawer and [Navigator.pop] to
  /// close it.
  ///
  /// ** See code in examples/api/lib/material/scaffold/scaffold.end_drawer.0.dart **
  /// {@end-tool}
  final Widget? endDrawer;

  /// Optional callback that is called when the [Scaffold.endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  ///
  /// If this is null, then [DrawerThemeData.scrimColor] is used. If that
  /// is also null, then it defaults to [Colors.black54].
  final Color? drawerScrimColor;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  ///
  /// Snack bars slide from underneath the bottom navigation bar while bottom
  /// sheets are stacked on top.
  ///
  /// The [bottomNavigationBar] is rendered below the [persistentFooterButtons]
  /// and the [body].
  final Widget? bottomNavigationBar;

  /// The persistent bottom sheet to display.
  ///
  /// A persistent bottom sheet shows information that supplements the primary
  /// content of the app. A persistent bottom sheet remains visible even when
  /// the user interacts with other parts of the app.
  ///
  /// A closely related widget is a modal bottom sheet, which is an alternative
  /// to a menu or a dialog and prevents the user from interacting with the rest
  /// of the app. Modal bottom sheets can be created and displayed with the
  /// [showModalBottomSheet] function.
  ///
  /// Unlike the persistent bottom sheet displayed by [showBottomSheet]
  /// this bottom sheet is not a [LocalHistoryEntry] and cannot be dismissed
  /// with the scaffold appbar's back button.
  ///
  /// If a persistent bottom sheet created with [showBottomSheet] is already
  /// visible, it must be closed before building the Scaffold with a new
  /// [bottomSheet].
  ///
  /// The value of [bottomSheet] can be any widget at all. It's unlikely to
  /// actually be a [BottomSheet], which is used by the implementations of
  /// [showBottomSheet] and [showModalBottomSheet]. Typically it's a widget
  /// that includes [Material].
  ///
  /// See also:
  ///
  ///  * [showBottomSheet], which displays a bottom sheet as a route that can
  ///    be dismissed with the scaffold's back button.
  ///  * [showModalBottomSheet], which displays a modal bottom sheet.
  ///  * [BottomSheetThemeData], which can be used to customize the default
  ///    bottom sheet property values when using a [BottomSheet].
  final Widget? bottomSheet;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined by the
  /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true.
  final bool? resizeToAvoidBottomInset;

  /// {@macro flutter.material.DrawerController.dragStartBehavior}
  final DragStartBehavior drawerDragStartBehavior;

  /// The width of the area within which a horizontal swipe will open the
  /// drawer.
  ///
  /// By default, the value used is 20.0 added to the padding edge of
  /// `MediaQuery.paddingOf(context)` that corresponds to the surrounding
  /// [TextDirection]. This ensures that the drag area for notched devices is
  /// not obscured. For example, if `TextDirection.of(context)` is set to
  /// [TextDirection.ltr], 20.0 will be added to
  /// `MediaQuery.paddingOf(context).left`.
  final double? drawerEdgeDragWidth;

  /// Determines if the [Scaffold.drawer] can be opened with a drag
  /// gesture on mobile.
  ///
  /// On desktop platforms, the drawer is not draggable.
  ///
  /// By default, the drag gesture is enabled on mobile.
  final bool drawerEnableOpenDragGesture;

  /// Determines if the [Scaffold.endDrawer] can be opened with a
  /// gesture on mobile.
  ///
  /// On desktop platforms, the drawer is not draggable.
  ///
  /// By default, the drag gesture is enabled on mobile.
  final bool endDrawerEnableOpenDragGesture;

  /// If true, and [bottomNavigationBar] or [persistentFooterButtons]
  /// is specified, then the [body] extends to the bottom of the Scaffold,
  /// instead of only extending to the top of the [bottomNavigationBar]
  /// or the [persistentFooterButtons].
  ///
  /// If true, a [MediaQuery] widget whose bottom padding matches the height
  /// of the [bottomNavigationBar] will be added above the scaffold's [body].
  ///
  /// This property is often useful when the [bottomNavigationBar] has
  /// a non-rectangular shape, like [CircularNotchedRectangle], which
  /// adds a [FloatingActionButton] sized notch to the top edge of the bar.
  /// In this case specifying `extendBody: true` ensures that scaffold's
  /// body will be visible through the bottom navigation bar's notch.
  ///
  /// See also:
  ///
  ///  * [extendBodyBehindAppBar], which extends the height of the body
  ///    to the top of the scaffold.
  final bool extendBody;

  @override
  State<SuperScaffold> createState() => _SuperScaffoldState();
}

class _SuperScaffoldState extends State<SuperScaffold> {
  double _scrollOffset = 0;
  bool _collapsed = false;
  bool isSubmitted = false;
  late TextEditingController _editingController;
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  late NavigationBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = NavigationBarStaticComponentsKeys();
    _editingController =
        widget.appBar!.searchBar!.searchController ?? TextEditingController();
    _focusNode = widget.appBar!.searchBar!.searchFocusNode ?? FocusNode();
    _scrollController = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        _scrollOffset = _scrollController.offset;
        Store.instance.scrollOffset.value = _scrollController.offset;
        checkIfCollapsed();
      });
    });
  }

  checkIfCollapsed() {
    if (widget.appBar!.searchBar!.scrollBehavior ==
        SearchBarScrollBehavior.floated) {
      if (_scrollOffset >=
          widget.measures.largeTitleContainerHeight +
              widget.measures.searchContainerHeight) {
        if (!_collapsed) {
          if (widget.onCollapsed != null) {
            widget.onCollapsed!(true);
          }
          _collapsed = true;
        }
      } else {
        if (_collapsed) {
          if (widget.onCollapsed != null) {
            widget.onCollapsed!(false);
          }
          _collapsed = false;
        }
      }
    } else {
      if (_scrollOffset >= widget.measures.largeTitleContainerHeight) {
        if (!_collapsed) {
          if (widget.onCollapsed != null) {
            widget.onCollapsed!(true);
          }
          _collapsed = true;
        }
      } else {
        if (_collapsed) {
          if (widget.onCollapsed != null) {
            widget.onCollapsed!(false);
          }
          _collapsed = false;
        }
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (Store.instance.searchBarHasFocus.value) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBarStaticComponents components =
        NavigationBarStaticComponents(
      keys: keys,
      route: ModalRoute.of(context),
      userLeading: widget.appBar!.leading,
      automaticallyImplyLeading: widget.appBar!.automaticallyImplyLeading,
      automaticallyImplyTitle: true,
      previousPageTitle: widget.appBar!.previousPageTitle,
      userMiddle: widget.appBar!.title,
      userTrailing: widget.appBar!.actions,
      largeTitleActions:
          Row(children: [...?widget.appBar!.largeTitle!.actions]),
      userLargeTitle: Text(
        widget.appBar!.largeTitle!.largeTitle,
        style: widget.appBar!.largeTitle!.textStyle.copyWith(
          color: widget.appBar!.largeTitle!.textStyle.color ??
              Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      appbarBottom: widget.appBar!.bottom!.child,
      padding: null,
      large: true,
    );

    double topPadding = MediaQuery.of(context).padding.top;

    return ConditionalWillPopScope(
      onWillPop: _onWillPop,
      shouldAddCallback: Store.instance.searchBarHasFocus.value,
      child: Scaffold(
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        persistentFooterAlignment: widget.persistentFooterAlignment,
        drawer: widget.drawer,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        drawerScrimColor: widget.drawerScrimColor,
        onDrawerChanged: widget.onDrawerChanged,
        onEndDrawerChanged: widget.onEndDrawerChanged,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        extendBody: widget.extendBody,
        endDrawer: widget.endDrawer,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
        backgroundColor: CupertinoDynamicColor.maybeResolve(
                widget.backgroundColor, context) ??
            Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              NestedScrollViewPlus(
                physics: SnapScrollPhysics(
                  parent: const BouncingScrollPhysics(),
                  snaps: [
                    if (widget.appBar!.searchBar!.scrollBehavior ==
                        SearchBarScrollBehavior.floated)
                      Snap.avoidZone(0, widget.measures.searchContainerHeight),
                    if (widget.appBar!.searchBar!.scrollBehavior ==
                        SearchBarScrollBehavior.floated)
                      Snap.avoidZone(
                          widget.measures.searchContainerHeight,
                          widget.measures.largeTitleContainerHeight +
                              widget.measures.searchContainerHeight),
                    if (widget.appBar!.searchBar!.scrollBehavior ==
                        SearchBarScrollBehavior.pinned)
                      Snap.avoidZone(
                          0, widget.measures.largeTitleContainerHeight),
                  ],
                ),
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) => [
                  OverlapAbsorberPlus(
                    sliver: SliverToBoxAdapter(
                      child: ValueListenableBuilder(
                          valueListenable:
                              Store.instance.searchBarAnimationStatus,
                          builder: (context, animationStatus, child) {
                            return AnimatedContainer(
                              duration: animationStatus ==
                                      SearchBarAnimationStatus.paused
                                  ? Duration.zero
                                  : widget.measures.searchBarAnimationDuration,
                              height: Store.instance.searchBarHasFocus.value
                                  ? (widget.appBar!.searchBar!
                                              .animationBehavior ==
                                          SearchBarAnimationBehavior.top
                                      ? topPadding +
                                          widget
                                              .measures.searchContainerHeight +
                                          widget.measures.bottomToolbarHeight
                                              .toDouble()
                                      : topPadding +
                                          widget.measures.appbarHeight)
                                  : topPadding + widget.measures.appbarHeight,
                            );
                          }),
                    ),
                  )
                ],
                body: widget.body,
              ),
              ValueListenableBuilder(
                  valueListenable: Store.instance.searchBarResultVisible,
                  builder: (context, searchBarResultVisible, child) {
                    return IgnorePointer(
                      ignoring: !searchBarResultVisible,
                      child: AnimatedOpacity(
                        duration: widget.measures.searchBarAnimationDuration,
                        opacity: searchBarResultVisible ? 1 : 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: CupertinoDynamicColor.maybeResolve(
                                  widget.appBar!.searchBar!.resultColor,
                                  context) ??
                              CupertinoTheme.of(context)
                                  .scaffoldBackgroundColor,
                          padding: EdgeInsets.only(
                            top: topPadding +
                                widget.measures.searchContainerHeight
                                    .toDouble() +
                                widget.measures.bottomToolbarHeight.toDouble(),
                          ),
                          child: Stack(
                            children: [
                              const Text(
                                ".",
                                style: TextStyle(color: Colors.transparent),
                              ),
                              widget.appBar!.searchBar!.searchResult,
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              ValueListenableBuilder(
                valueListenable: Store.instance.scrollOffset,
                builder: (context, scrollOffset, child) {
                  // full appbar height
                  double fullappbarheight =
                      widget.appBar!.searchBar!.scrollBehavior ==
                              SearchBarScrollBehavior.floated
                          ? clampDouble(
                              topPadding +
                                  widget.measures.appbarHeight -
                                  _scrollOffset,
                              topPadding +
                                  widget.measures.primaryToolbarHeight +
                                  widget.appBar!.bottom!.height,
                              widget.stretch
                                  ? 3000
                                  : topPadding + widget.measures.appbarHeight)
                          : clampDouble(
                              topPadding +
                                  widget.measures.appbarHeight -
                                  _scrollOffset,
                              topPadding +
                                  widget.measures.appbarHeight -
                                  widget.measures.largeTitleContainerHeight,
                              widget.stretch
                                  ? 3000
                                  : topPadding + widget.measures.appbarHeight);

                  // large title height
                  double largeTitleHeight = widget
                              .appBar!.searchBar!.scrollBehavior ==
                          SearchBarScrollBehavior.floated
                      ? (_scrollOffset > widget.measures.searchContainerHeight
                          ? clampDouble(
                              widget.measures.largeTitleContainerHeight -
                                  (_scrollOffset -
                                      widget.measures.searchContainerHeight),
                              0,
                              widget.measures.largeTitleContainerHeight)
                          : widget.measures.largeTitleContainerHeight)
                      : clampDouble(
                          widget.measures.largeTitleContainerHeight -
                              _scrollOffset,
                          0,
                          widget.measures.largeTitleContainerHeight);

                  // searchbar height
                  double searchBarHeight =
                      widget.appBar!.searchBar!.scrollBehavior ==
                              SearchBarScrollBehavior.floated
                          ? (Store.instance.searchBarHasFocus.value
                              ? widget.measures.searchContainerHeight
                              : clampDouble(
                                  widget.measures.searchContainerHeight -
                                      _scrollOffset,
                                  0,
                                  widget.measures.searchContainerHeight))
                          : widget.measures.searchContainerHeight;

                  double opacity = widget.appBar!.searchBar!.scrollBehavior ==
                          SearchBarScrollBehavior.floated
                      ? (Store.instance.searchBarHasFocus.value
                          ? 1
                          : clampDouble(1 - _scrollOffset / 10, 0, 1))
                      : 1;

                  double titleOpacity =
                      widget.appBar!.searchBar!.scrollBehavior ==
                              SearchBarScrollBehavior.floated
                          ? (_scrollOffset >=
                                  (widget.measures
                                          .appbarHeightExceptPrimaryToolbar -
                                      widget.appBar!.bottom!.height)
                              ? 1
                              : (widget.measures.largeTitleContainerHeight > 0
                                  ? 0
                                  : 1))
                          : (_scrollOffset >=
                                  (widget.measures.largeTitleContainerHeight)
                              ? 1
                              : (widget.measures.largeTitleContainerHeight > 0
                                  ? 0
                                  : 1));

                  double focussedToolbar = topPadding +
                      widget.measures.searchContainerHeight +
                      widget.appBar!.bottom!.height;

                  double scaleTitle = _scrollOffset < 0
                      ? clampDouble((1 - _scrollOffset / 1500), 1, 1.12)
                      : 1;

                  if (widget.appBar!.searchBar!.animationBehavior ==
                          SearchBarAnimationBehavior.steady &&
                      Store.instance.searchBarHasFocus.value) {
                    fullappbarheight =
                        topPadding + widget.measures.appbarHeight;
                    largeTitleHeight =
                        widget.measures.largeTitleContainerHeight;
                    scaleTitle = 1;
                    titleOpacity = 0;
                  }
                  if (!widget.stretch) scaleTitle = 1;
                  if (widget.appBar!.alwaysShowTitle) titleOpacity = 1;
                  if (!widget.appBar!.searchBar!.enabled) opacity = 0;

                  return ValueListenableBuilder(
                      valueListenable: Store.instance.searchBarAnimationStatus,
                      builder: (context, animationStatus, child) {
                        return AnimatedPositioned(
                          duration:
                              animationStatus == SearchBarAnimationStatus.paused
                                  ? Duration.zero
                                  : widget.measures.searchBarAnimationDuration,
                          top: 0,
                          left: 0,
                          right: 0,
                          height: Store.instance.searchBarHasFocus.value
                              ? (widget.appBar!.searchBar!.animationBehavior ==
                                      SearchBarAnimationBehavior.top
                                  ? focussedToolbar
                                  : fullappbarheight)
                              : fullappbarheight,
                          child: wrapWithBackground(
                            border: widget.appBar!.border,
                            backgroundColor: CupertinoDynamicColor.maybeResolve(
                                    widget.appBar!.backgroundColor, context) ??
                                CupertinoTheme.of(context).barBackgroundColor,
                            brightness: widget.brightness,
                            child: Builder(builder: (context) {
                              Widget childd = Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AnimatedContainer(
                                    height: Store
                                            .instance.searchBarHasFocus.value
                                        ? (widget.appBar!.searchBar!
                                                    .animationBehavior ==
                                                SearchBarAnimationBehavior.top
                                            ? MediaQuery.paddingOf(context).top
                                            : widget.measures
                                                    .primaryToolbarHeight +
                                                MediaQuery.paddingOf(context)
                                                    .top)
                                        : widget.measures
                                                .primaryToolbarHeight +
                                            MediaQuery.paddingOf(context).top,
                                    duration: animationStatus ==
                                            SearchBarAnimationStatus.paused
                                        ? Duration.zero
                                        : widget.measures
                                            .searchBarAnimationDuration,
                                    child: PersistentNavigationBar(
                                      components: components,
                                      middleVisible:
                                          widget.appBar!.alwaysShowTitle
                                              ? null
                                              : titleOpacity != 0,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: widget.appBar!.largeTitle!.padding,
                                    child: AnimatedOpacity(
                                      duration: animationStatus ==
                                              SearchBarAnimationStatus.paused
                                          ? Duration.zero
                                          : widget.measures
                                              .titleOpacityAnimationDuration,
                                      opacity: Store
                                              .instance.searchBarHasFocus.value
                                          ? (widget.appBar!.searchBar!
                                                      .animationBehavior ==
                                                  SearchBarAnimationBehavior.top
                                              ? 0
                                              : 1)
                                          : 1,
                                      child: AnimatedContainer(
                                        height: Store.instance.searchBarHasFocus
                                                .value
                                            ? (widget.appBar!.searchBar!
                                                        .animationBehavior ==
                                                    SearchBarAnimationBehavior
                                                        .top
                                                ? 0
                                                : largeTitleHeight)
                                            : largeTitleHeight,
                                        duration: animationStatus ==
                                                SearchBarAnimationStatus.paused
                                            ? Duration.zero
                                            : widget.measures
                                                .searchBarAnimationDuration,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: widget.measures
                                                          .largeTitleContainerHeight >
                                                      0
                                                  ? 8.0
                                                  : 0),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: scaleTitle,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child:
                                                          components.largeTitle,
                                                    ),
                                                    const Spacer(),
                                                    components
                                                        .largeTitleActions!,
                                                    /*...?widget
                                                                  .appBar!
                                                                  .largeTitle!
                                                                  .actions*/
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: widget.appBar!.searchBar!.padding,
                                    child: SizedBox(
                                      height: searchBarHeight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Measures.instance
                                                .searchBarBottomPadding),
                                        child: Stack(
                                          children: [
                                            KeyedSubtree(
                                              key: keys.searchBarKey,
                                              child: IgnorePointer(
                                                ignoring: true,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Flexible(
                                                      child:
                                                          CupertinoSearchTextField(
                                                        prefixIcon: Opacity(
                                                          opacity: Store
                                                                  .instance
                                                                  .searchBarHasFocus
                                                                  .value
                                                              ? 0
                                                              : opacity,
                                                          child: widget
                                                              .appBar!
                                                              .searchBar!
                                                              .prefixIcon,
                                                        ),
                                                        placeholder: Store
                                                                .instance
                                                                .searchBarHasFocus
                                                                .value
                                                            ? ""
                                                            : widget
                                                                .appBar!
                                                                .searchBar!
                                                                .placeholderText,
                                                        placeholderStyle: widget
                                                            .appBar!
                                                            .searchBar!
                                                            .placeholderTextStyle
                                                            .copyWith(
                                                          color: widget
                                                              .appBar!
                                                              .searchBar!
                                                              .placeholderTextStyle
                                                              .color!
                                                              .withOpacity(
                                                                  opacity),
                                                        ),
                                                        style: widget
                                                            .appBar!
                                                            .searchBar!
                                                            .textStyle
                                                            .copyWith(
                                                          color: widget
                                                                  .appBar!
                                                                  .searchBar!
                                                                  .textStyle
                                                                  .color ??
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .color,
                                                        ),
                                                        backgroundColor: widget
                                                            .appBar!
                                                            .searchBar!
                                                            .backgroundColor,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        for (SuperAction searchAction
                                                            in widget
                                                                .appBar!
                                                                .searchBar!
                                                                .actions)
                                                          searchAction.behavior ==
                                                                  SuperActionBehavior
                                                                      .alwaysVisible
                                                              ? searchAction
                                                              : const SizedBox(),
                                                        AnimatedCrossFade(
                                                            firstChild: Center(
                                                              child: Row(
                                                                children: widget
                                                                    .appBar!
                                                                    .searchBar!
                                                                    .actions
                                                                    .where((e) =>
                                                                        e.behavior ==
                                                                        SuperActionBehavior
                                                                            .visibleOnFocus)
                                                                    .toList(),
                                                              ),
                                                            ),
                                                            secondChild:
                                                                const SizedBox(),
                                                            crossFadeState: Store
                                                                    .instance
                                                                    .searchBarHasFocus
                                                                    .value
                                                                ? CrossFadeState
                                                                    .showFirst
                                                                : CrossFadeState
                                                                    .showSecond,
                                                            duration: widget
                                                                .measures
                                                                .standartAnimationDuration),
                                                        AnimatedCrossFade(
                                                            firstChild: Center(
                                                              child: Row(
                                                                children: widget
                                                                    .appBar!
                                                                    .searchBar!
                                                                    .actions
                                                                    .where((e) =>
                                                                        e.behavior ==
                                                                        SuperActionBehavior
                                                                            .visibleOnUnFocus)
                                                                    .toList(),
                                                              ),
                                                            ),
                                                            secondChild:
                                                                const SizedBox(),
                                                            crossFadeState: Store
                                                                    .instance
                                                                    .searchBarHasFocus
                                                                    .value
                                                                ? CrossFadeState
                                                                    .showSecond
                                                                : CrossFadeState
                                                                    .showFirst,
                                                            duration: widget
                                                                .measures
                                                                .standartAnimationDuration),
                                                        Center(
                                                          child:
                                                              CupertinoButton(
                                                            minSize: 0,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            color: Colors
                                                                .transparent,
                                                            onPressed: () {
                                                              searchBarFocusThings(
                                                                  false);
                                                              _focusNode
                                                                  .unfocus();
                                                              _editingController
                                                                  .clear();
                                                            },
                                                            child:
                                                                AnimatedContainer(
                                                              duration: widget
                                                                  .measures
                                                                  .standartAnimationDuration,
                                                              width: Store
                                                                      .instance
                                                                      .searchBarHasFocus
                                                                      .value
                                                                  ? textSize(
                                                                      widget
                                                                          .appBar!
                                                                          .searchBar!
                                                                          .cancelButtonText,
                                                                      widget
                                                                          .appBar!
                                                                          .searchBar!
                                                                          .cancelTextStyle)
                                                                  : 0,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    widget
                                                                        .appBar!
                                                                        .searchBar!
                                                                        .cancelButtonText,
                                                                    style: widget
                                                                        .appBar!
                                                                        .searchBar!
                                                                        .cancelTextStyle,
                                                                    maxLines:
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Flexible(
                                                  child: Focus(
                                                    onFocusChange: (hasFocus) {
                                                      if (isSubmitted) {
                                                        isSubmitted = false;
                                                        return;
                                                      }
                                                      searchBarFocusThings(
                                                          hasFocus);
                                                      setState(() {});
                                                    },
                                                    child:
                                                        CupertinoSearchTextField(
                                                      onSubmitted: (s) {
                                                        isSubmitted = true;
                                                        widget
                                                            .appBar!
                                                            .searchBar!
                                                            .onSubmitted
                                                            ?.call(s);
                                                      },
                                                      onChanged: (v) {
                                                        if (v.isNotEmpty) {
                                                          if (widget
                                                                  .appBar!
                                                                  .searchBar!
                                                                  .resultBehavior ==
                                                              SearchBarResultBehavior
                                                                  .visibleOnInput) {
                                                            Store
                                                                .instance
                                                                .searchBarResultVisible
                                                                .value = true;
                                                          }
                                                        } else {
                                                          if (widget
                                                                  .appBar!
                                                                  .searchBar!
                                                                  .resultBehavior ==
                                                              SearchBarResultBehavior
                                                                  .visibleOnInput) {
                                                            Store
                                                                .instance
                                                                .searchBarResultVisible
                                                                .value = false;
                                                          }
                                                        }
                                                        widget
                                                            .appBar!
                                                            .searchBar!
                                                            .onChanged
                                                            ?.call(v);
                                                      },
                                                      prefixIcon: Opacity(
                                                        opacity: opacity,
                                                        child: widget
                                                            .appBar!
                                                            .searchBar!
                                                            .prefixIcon,
                                                      ),
                                                      placeholder: widget
                                                          .appBar!
                                                          .searchBar!
                                                          .placeholderText,
                                                      placeholderStyle: widget
                                                          .appBar!
                                                          .searchBar!
                                                          .placeholderTextStyle
                                                          .copyWith(
                                                        color: widget
                                                            .appBar!
                                                            .searchBar!
                                                            .placeholderTextStyle
                                                            .color!
                                                            .withOpacity(
                                                                opacity),
                                                      ),
                                                      style: widget.appBar!
                                                          .searchBar!.textStyle
                                                          .copyWith(
                                                        color: widget
                                                                .appBar!
                                                                .searchBar!
                                                                .textStyle
                                                                .color ??
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .color,
                                                      ),
                                                      controller:
                                                          _editingController,
                                                      focusNode: _focusNode,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      autocorrect: false,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    for (SuperAction searchAction
                                                        in widget.appBar!
                                                            .searchBar!.actions)
                                                      searchAction.behavior ==
                                                              SuperActionBehavior
                                                                  .alwaysVisible
                                                          ? searchAction
                                                          : const SizedBox(),
                                                    AnimatedCrossFade(
                                                        firstChild: Center(
                                                          child: Row(
                                                            children: widget
                                                                .appBar!
                                                                .searchBar!
                                                                .actions
                                                                .where((e) =>
                                                                    e.behavior ==
                                                                    SuperActionBehavior
                                                                        .visibleOnFocus)
                                                                .toList(),
                                                          ),
                                                        ),
                                                        secondChild:
                                                            const SizedBox(),
                                                        crossFadeState: Store
                                                                .instance
                                                                .searchBarHasFocus
                                                                .value
                                                            ? CrossFadeState
                                                                .showFirst
                                                            : CrossFadeState
                                                                .showSecond,
                                                        duration: widget
                                                            .measures
                                                            .standartAnimationDuration),
                                                    AnimatedCrossFade(
                                                        firstChild: Center(
                                                          child: Row(
                                                            children: widget
                                                                .appBar!
                                                                .searchBar!
                                                                .actions
                                                                .where((e) =>
                                                                    e.behavior ==
                                                                    SuperActionBehavior
                                                                        .visibleOnUnFocus)
                                                                .toList(),
                                                          ),
                                                        ),
                                                        secondChild:
                                                            const SizedBox(),
                                                        crossFadeState: Store
                                                                .instance
                                                                .searchBarHasFocus
                                                                .value
                                                            ? CrossFadeState
                                                                .showSecond
                                                            : CrossFadeState
                                                                .showFirst,
                                                        duration: widget
                                                            .measures
                                                            .standartAnimationDuration),
                                                    Center(
                                                      child: CupertinoButton(
                                                        minSize: 0,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        color:
                                                            Colors.transparent,
                                                        onPressed: () {
                                                          searchBarFocusThings(
                                                              false);
                                                          _focusNode.unfocus();
                                                          _editingController
                                                              .clear();
                                                        },
                                                        child:
                                                            AnimatedContainer(
                                                          duration: widget
                                                              .measures
                                                              .standartAnimationDuration,
                                                          width: Store
                                                                  .instance
                                                                  .searchBarHasFocus
                                                                  .value
                                                              ? textSize(
                                                                  widget
                                                                      .appBar!
                                                                      .searchBar!
                                                                      .cancelButtonText,
                                                                  widget
                                                                      .appBar!
                                                                      .searchBar!
                                                                      .cancelTextStyle)
                                                              : 0,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                                widget
                                                                    .appBar!
                                                                    .searchBar!
                                                                    .cancelButtonText,
                                                                style: widget
                                                                    .appBar!
                                                                    .searchBar!
                                                                    .cancelTextStyle,
                                                                maxLines: 1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: widget
                                        .measures.searchBarAnimationDuration,
                                    height:
                                        widget.measures.bottomToolbarHeight,
                                    color: widget.appBar!.bottom!.color,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          height: widget
                                              .measures.bottomToolbarHeight,
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: components.appbarBottom!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );

                              if (!widget.transitionBetweenRoutes ||
                                  !isTransitionable(context)) {
                                return childd;
                              }

                              return Hero(
                                tag: HeroTag(Navigator.of(context)),
                                createRectTween:
                                    linearTranslateWithLargestRectSizeTween,
                                flightShuttleBuilder:
                                    navBarHeroFlightShuttleBuilder,
                                placeholderBuilder: navBarHeroLaunchPadBuilder,
                                transitionOnUserGestures: true,
                                child: TransitionableNavigationBar(
                                  componentsKeys: keys,
                                  backgroundColor:
                                      CupertinoDynamicColor.maybeResolve(
                                              widget.appBar!.backgroundColor,
                                              context) ??
                                          CupertinoTheme.of(context)
                                              .barBackgroundColor,
                                  backButtonTextStyle:
                                      CupertinoTheme.of(context)
                                          .textTheme
                                          .navActionTextStyle,
                                  titleTextStyle: CupertinoTheme.of(context)
                                      .textTheme
                                      .navTitleTextStyle,
                                  largeTitleTextStyle:
                                      widget.appBar!.largeTitle!.textStyle,
                                  border: const Border(),
                                  hasUserMiddle: _collapsed,
                                  largeExpanded: !_collapsed &&
                                      widget.appBar!.largeTitle!.enabled,
                                  searchBarHasFocus:
                                      Store.instance.searchBarHasFocus.value,
                                  child: childd,
                                ),
                              );
                            }),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchBarFocusThings(bool hasFocus) {
    Store.instance.searchBarHasFocus.value = hasFocus;

    Store.instance.searchBarAnimationStatus.value = hasFocus
        ? SearchBarAnimationStatus.started
        : SearchBarAnimationStatus.onGoing;
    if (hasFocus) {
      if (widget.appBar!.searchBar!.resultBehavior ==
          SearchBarResultBehavior.visibleOnFocus) {
        Store.instance.searchBarResultVisible.value = true;
      }
    } else {
      Store.instance.searchBarResultVisible.value = false;
    }
    if (!hasFocus) {
      Future.delayed(widget.measures.searchBarAnimationDuration, () {
        Store.instance.searchBarAnimationStatus.value =
            SearchBarAnimationStatus.paused;
      });
    }
    widget.appBar!.searchBar!.onFocused?.call(hasFocus);
  }
}

// Here it is!
double textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width * 1.4;
}
