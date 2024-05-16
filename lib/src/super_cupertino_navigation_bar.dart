import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';
import 'package:super_cupertino_navigation_bar/models/super_appbar.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar_action.model.dart';
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
    required this.appBar,
    this.stretch = true,
    this.body = const SizedBox(),
    this.onCollapsed,
    this.brightness,
    this.scrollController,
    this.physics = const BouncingScrollPhysics(),
    this.transitionBetweenRoutes = true,
  }) : super(key: key) {
    measures = Measures(
      searchTextFieldHeight: appBar.searchBar!.height,
      largeTitleContainerHeight: appBar.largeTitle!.height,
      primaryToolbarHeight: appBar.height,
      bottomToolbarHeight: appBar.bottom!.height,
      searchBarAnimationDurationx: appBar.searchBar!.animationDuration,
    );
  }

  /// Whether the nav bar should stretch to fill the over-scroll area.
  ///
  /// The nav bar can still expand and contract as the user scrolls, but it will
  /// also stretch when the user over-scrolls if the [stretch] value is `true`.
  ///
  /// When set to `true`, the nav bar will prevent subsequent slivers from
  /// accessing overscrolls. This may be undesirable for using overscroll-based
  /// widgets like the [CupertinoSliverRefreshControl].
  ///
  /// Defaults to `true`.
  final bool stretch;

  /// {@template flutter.cupertino.CupertinoNavigationBar.transitionBetweenRoutes}
  /// Whether to transition between navigation bars.
  ///
  /// When [transitionBetweenRoutes] is true, this navigation bar will transition
  /// on top of the routes instead of inside it if the route being transitioned
  /// to also has a [CupertinoNavigationBar] or a [CupertinoSliverNavigationBar]
  /// with [transitionBetweenRoutes] set to true.
  ///
  /// This transition will also occur on edge back swipe gestures like on iOS
  /// but only if the previous page below has `maintainState` set to true on the
  /// [PageRoute].
  ///
  /// When set to true, only one navigation bar can be present per route unless
  /// [heroTag] is also set.
  ///
  /// This value defaults to true.
  /// {@endtemplate}
  final bool transitionBetweenRoutes;

  /// {@template flutter.cupertino.CupertinoNavigationBar.brightness}
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

  /// This value defaults to [Measures].
  late final Measures measures;

  /// Required.
  final SuperAppBar appBar;

  /// Can be any widget.
  /// Defaults to SizedBox()
  final Widget body;

  final Function(bool)? onCollapsed;
  late final ScrollController? scrollController;
  final ScrollPhysics? physics;

  @override
  State<SuperScaffold> createState() => _SuperScaffoldState();
}

class _SuperScaffoldState extends State<SuperScaffold> {
  double _scrollOffset = 0;
  bool _collapsed = false;
  late TextEditingController _editingController;
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  late NavigationBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = NavigationBarStaticComponentsKeys();
    _editingController =
        widget.appBar.searchBar!.searchController ?? TextEditingController();
    _focusNode = widget.appBar.searchBar!.searchFocusNode ?? FocusNode();
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
    if (widget.appBar.searchBar!.scrollBehavior ==
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

  @override
  Widget build(BuildContext context) {
    final NavigationBarStaticComponents components =
        NavigationBarStaticComponents(
      keys: keys,
      route: ModalRoute.of(context),
      userLeading: widget.appBar.leading,
      automaticallyImplyLeading: widget.appBar.automaticallyImplyLeading,
      automaticallyImplyTitle: true,
      previousPageTitle: widget.appBar.previousPageTitle,
      userMiddle: widget.appBar.title,
      userTrailing: widget.appBar.actions,
      largeTitleActions: Row(children: [...?widget.appBar.largeTitle!.actions]),
      userLargeTitle: Text(
        widget.appBar.largeTitle!.largeTitle,
        style: widget.appBar.largeTitle!.textStyle.copyWith(
          color: widget.appBar.largeTitle!.textStyle.color ??
              Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      appbarBottom: widget.appBar.bottom!.child,
      padding: null,
      large: true,
    );

    double topPadding = MediaQuery.of(context).padding.top;

    return PopScope(
      canPop: !Store.instance.searchBarHasFocus.value,
      // shouldAddCallback: Store.instance.searchBarHasFocus.value,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            NestedScrollViewPlus(
              physics: SnapScrollPhysics(
                parent: widget.physics ?? const BouncingScrollPhysics(),
                snaps: [
                  if (widget.appBar.searchBar!.scrollBehavior ==
                      SearchBarScrollBehavior.floated)
                    Snap.avoidZone(0, widget.measures.searchContainerHeight),
                  if (widget.appBar.searchBar!.scrollBehavior ==
                      SearchBarScrollBehavior.floated)
                    Snap.avoidZone(
                        widget.measures.searchContainerHeight,
                        widget.measures.largeTitleContainerHeight +
                            widget.measures.searchContainerHeight),
                  if (widget.appBar.searchBar!.scrollBehavior ==
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
                                ? (widget.appBar.searchBar!.animationBehavior ==
                                        SearchBarAnimationBehavior.top
                                    ? topPadding +
                                        widget.measures.searchContainerHeight +
                                        widget.measures.bottomToolbarHeight
                                            .toDouble()
                                    : topPadding + widget.measures.appbarHeight)
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
                                widget.appBar.searchBar!.resultColor,
                                context) ??
                            CupertinoTheme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.only(
                          top: topPadding +
                              widget.measures.searchContainerHeight.toDouble() +
                              widget.measures.bottomToolbarHeight.toDouble(),
                        ),
                        child: Stack(
                          children: [
                            const Text(
                              ".",
                              style: TextStyle(color: Colors.transparent),
                            ),
                            widget.appBar.searchBar!.searchResult,
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
                    widget.appBar.searchBar!.scrollBehavior ==
                            SearchBarScrollBehavior.floated
                        ? clampDouble(
                            topPadding +
                                widget.measures.appbarHeight -
                                _scrollOffset,
                            topPadding +
                                widget.measures.primaryToolbarHeight +
                                widget.appBar.bottom!.height,
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
                double largeTitleHeight =
                    widget.appBar.searchBar!.scrollBehavior ==
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
                    widget.appBar.searchBar!.scrollBehavior ==
                            SearchBarScrollBehavior.floated
                        ? (Store.instance.searchBarHasFocus.value
                            ? widget.measures.searchContainerHeight
                            : clampDouble(
                                widget.measures.searchContainerHeight -
                                    _scrollOffset,
                                0,
                                widget.measures.searchContainerHeight))
                        : widget.measures.searchContainerHeight;

                double opacity = widget.appBar.searchBar!.scrollBehavior ==
                        SearchBarScrollBehavior.floated
                    ? (Store.instance.searchBarHasFocus.value
                        ? 1
                        : clampDouble(1 - _scrollOffset / 10, 0, 1))
                    : 1;

                double titleOpacity = widget.appBar.searchBar!.scrollBehavior ==
                        SearchBarScrollBehavior.floated
                    ? (_scrollOffset >=
                            (widget.measures.appbarHeightExceptPrimaryToolbar -
                                widget.appBar.bottom!.height)
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
                    widget.appBar.bottom!.height;

                double scaleTitle = _scrollOffset < 0
                    ? clampDouble((1 - _scrollOffset / 1500), 1, 1.12)
                    : 1;

                if (widget.appBar.searchBar!.animationBehavior ==
                        SearchBarAnimationBehavior.steady &&
                    Store.instance.searchBarHasFocus.value) {
                  fullappbarheight = topPadding + widget.measures.appbarHeight;
                  largeTitleHeight = widget.measures.largeTitleContainerHeight;
                  scaleTitle = 1;
                  titleOpacity = 0;
                }
                if (!widget.stretch) scaleTitle = 1;
                if (widget.appBar.alwaysShowTitle) titleOpacity = 1;
                if (!widget.appBar.searchBar!.enabled) opacity = 0;

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
                            ? (widget.appBar.searchBar!.animationBehavior ==
                                    SearchBarAnimationBehavior.top
                                ? focussedToolbar
                                : fullappbarheight)
                            : fullappbarheight,
                        child: wrapWithBackground(
                          border: widget.appBar.border,
                          backgroundColor: CupertinoDynamicColor.maybeResolve(
                                  widget.appBar.backgroundColor, context) ??
                              CupertinoTheme.of(context).barBackgroundColor,
                          brightness: widget.brightness,
                          child: Builder(builder: (context) {
                            Widget childd = Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  height: Store.instance.searchBarHasFocus.value
                                      ? (widget.appBar.searchBar!
                                                  .animationBehavior ==
                                              SearchBarAnimationBehavior.top
                                          ? MediaQuery.paddingOf(context).top
                                          : widget.measures
                                                  .primaryToolbarHeight +
                                              MediaQuery.paddingOf(context).top)
                                      : widget.measures.primaryToolbarHeight +
                                          MediaQuery.paddingOf(context).top,
                                  duration: animationStatus ==
                                          SearchBarAnimationStatus.paused
                                      ? Duration.zero
                                      : widget
                                          .measures.searchBarAnimationDuration,
                                  child: AnimatedOpacity(
                                    duration: animationStatus ==
                                            SearchBarAnimationStatus.paused
                                        ? Duration.zero
                                        : widget.measures
                                            .titleOpacityAnimationDuration,
                                    opacity: Store
                                            .instance.searchBarHasFocus.value
                                        ? (widget.appBar.searchBar!
                                                    .animationBehavior ==
                                                SearchBarAnimationBehavior.top
                                            ? 0
                                            : 1)
                                        : 1,
                                    child: PersistentNavigationBar(
                                      components: components,
                                      middleVisible:
                                          widget.appBar.alwaysShowTitle
                                              ? null
                                              : titleOpacity != 0,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: widget.appBar.largeTitle!.padding,
                                  child: AnimatedOpacity(
                                    duration: animationStatus ==
                                            SearchBarAnimationStatus.paused
                                        ? Duration.zero
                                        : widget.measures
                                            .titleOpacityAnimationDuration,
                                    opacity: Store
                                            .instance.searchBarHasFocus.value
                                        ? (widget.appBar.searchBar!
                                                    .animationBehavior ==
                                                SearchBarAnimationBehavior.top
                                            ? 0
                                            : 1)
                                        : 1,
                                    child: AnimatedContainer(
                                      height: Store
                                              .instance.searchBarHasFocus.value
                                          ? (widget.appBar.searchBar!
                                                      .animationBehavior ==
                                                  SearchBarAnimationBehavior.top
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
                                                  components.largeTitleActions!,
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
                                  padding: widget.appBar.searchBar!.padding,
                                  child: SizedBox(
                                    height: searchBarHeight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Measures
                                              .instance.searchBarBottomPadding),
                                      child: Stack(
                                        children: [
                                          KeyedSubtree(
                                            key: keys.searchBarKey,
                                            child: IgnorePointer(
                                              ignoring: true,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
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
                                                            .appBar
                                                            .searchBar!
                                                            .prefixIcon,
                                                      ),
                                                      placeholder: Store
                                                              .instance
                                                              .searchBarHasFocus
                                                              .value
                                                          ? ""
                                                          : widget
                                                              .appBar
                                                              .searchBar!
                                                              .placeholderText,
                                                      placeholderStyle: widget
                                                          .appBar
                                                          .searchBar!
                                                          .placeholderTextStyle
                                                          .copyWith(
                                                        color: widget
                                                            .appBar
                                                            .searchBar!
                                                            .placeholderTextStyle
                                                            .color!
                                                            .withOpacity(
                                                                opacity),
                                                      ),
                                                      style: widget.appBar
                                                          .searchBar!.textStyle
                                                          .copyWith(
                                                        color: widget
                                                                .appBar
                                                                .searchBar!
                                                                .textStyle
                                                                .color ??
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .color,
                                                      ),
                                                      backgroundColor: widget
                                                          .appBar
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
                                                              .appBar
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
                                                                  .appBar
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
                                                                  .appBar
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
                                                                        .appBar
                                                                        .searchBar!
                                                                        .cancelButtonText,
                                                                    widget
                                                                        .appBar
                                                                        .searchBar!
                                                                        .cancelTextStyle)
                                                                : 0,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                  widget
                                                                      .appBar
                                                                      .searchBar!
                                                                      .cancelButtonText,
                                                                  style: widget
                                                                      .appBar
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
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Flexible(
                                                child: Focus(
                                                  onFocusChange: (hasFocus) {
                                                    searchBarFocusThings(
                                                        hasFocus);
                                                    setState(() {});
                                                  },
                                                  child:
                                                      CupertinoSearchTextField(
                                                    onSubmitted: (s) {
                                                      widget.appBar.searchBar!
                                                          .onSubmitted
                                                          ?.call(s);
                                                    },
                                                    onChanged: (v) {
                                                      if (v.isNotEmpty) {
                                                        if (widget
                                                                .appBar
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
                                                                .appBar
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
                                                      widget.appBar.searchBar!
                                                          .onChanged
                                                          ?.call(v);
                                                    },
                                                    prefixIcon: Opacity(
                                                      opacity: opacity,
                                                      child: widget
                                                          .appBar
                                                          .searchBar!
                                                          .prefixIcon,
                                                    ),
                                                    placeholder: widget
                                                        .appBar
                                                        .searchBar!
                                                        .placeholderText,
                                                    placeholderStyle: widget
                                                        .appBar
                                                        .searchBar!
                                                        .placeholderTextStyle
                                                        .copyWith(
                                                      color: widget
                                                          .appBar
                                                          .searchBar!
                                                          .placeholderTextStyle
                                                          .color!
                                                          .withOpacity(opacity),
                                                    ),
                                                    style: widget.appBar
                                                        .searchBar!.textStyle
                                                        .copyWith(
                                                      color: widget
                                                              .appBar
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
                                                      in widget.appBar
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
                                                              .appBar
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
                                                      duration: widget.measures
                                                          .standartAnimationDuration),
                                                  AnimatedCrossFade(
                                                      firstChild: Center(
                                                        child: Row(
                                                          children: widget
                                                              .appBar
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
                                                      duration: widget.measures
                                                          .standartAnimationDuration),
                                                  Center(
                                                    child: CupertinoButton(
                                                      minSize: 0,
                                                      padding: EdgeInsets.zero,
                                                      color: Colors.transparent,
                                                      onPressed: () {
                                                        searchBarFocusThings(
                                                            false);
                                                        _focusNode.unfocus();
                                                        _editingController
                                                            .clear();
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: widget
                                                            .measures
                                                            .standartAnimationDuration,
                                                        width: Store
                                                                .instance
                                                                .searchBarHasFocus
                                                                .value
                                                            ? textSize(
                                                                widget
                                                                    .appBar
                                                                    .searchBar!
                                                                    .cancelButtonText,
                                                                widget
                                                                    .appBar
                                                                    .searchBar!
                                                                    .cancelTextStyle)
                                                            : 0,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              widget
                                                                  .appBar
                                                                  .searchBar!
                                                                  .cancelButtonText,
                                                              style: widget
                                                                  .appBar
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
                                  height: widget.measures.bottomToolbarHeight,
                                  color: widget.appBar.bottom!.color,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        height:
                                            widget.measures.bottomToolbarHeight,
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
                                            widget.appBar.backgroundColor,
                                            context) ??
                                        CupertinoTheme.of(context)
                                            .barBackgroundColor,
                                backButtonTextStyle: CupertinoTheme.of(context)
                                    .textTheme
                                    .navActionTextStyle,
                                titleTextStyle: CupertinoTheme.of(context)
                                    .textTheme
                                    .navTitleTextStyle,
                                largeTitleTextStyle:
                                    widget.appBar.largeTitle!.textStyle,
                                border: const Border(),
                                hasUserMiddle: _collapsed,
                                largeExpanded: !_collapsed &&
                                    widget.appBar.largeTitle!.enabled,
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
    );
  }

  void searchBarFocusThings(bool hasFocus) {
    Store.instance.searchBarHasFocus.value = hasFocus;

    Store.instance.searchBarAnimationStatus.value = hasFocus
        ? SearchBarAnimationStatus.started
        : SearchBarAnimationStatus.onGoing;
    if (hasFocus) {
      if (widget.appBar.searchBar!.resultBehavior ==
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
    widget.appBar.searchBar!.onFocused?.call(hasFocus);
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
