import 'package:flutter/material.dart';

import 'hero_tag.dart';

class Measures {
  static Measures? _instance;

  static Measures get instance {
    _instance ??= Measures(
      searchTextFieldHeight: 35,
      largeTitleContainerHeight: kToolbarHeight,
      primaryToolbarHeight: kToolbarHeight,
      bottomToolbarHeight: 35.0,
      searchBarAnimationDurationx: const Duration(milliseconds: 250),
    );

    return _instance!;
  }

  Measures({
    required this.searchTextFieldHeight,
    required this.largeTitleContainerHeight,
    required this.primaryToolbarHeight,
    required this.bottomToolbarHeight,
    required this.searchBarAnimationDurationx,
  });

  double largeTitleContainerHeight,
      primaryToolbarHeight,
      searchTextFieldHeight,
      bottomToolbarHeight;

  Duration searchBarAnimationDurationx;

  Duration get titleOpacityAnimationDuration =>
      const Duration(milliseconds: 100);

  Duration get standartAnimationDuration => const Duration(milliseconds: 200);
  Duration get scrollAnimationDuration => const Duration(milliseconds: 300);
  Duration get searchBarAnimationDuration => searchBarAnimationDurationx;

  double get appbarHeight =>
      primaryToolbarHeight +
      searchContainerHeight +
      largeTitleContainerHeight +
      bottomToolbarHeight;

  double get appbarHeightExceptPrimaryToolbar =>
      searchContainerHeight + largeTitleContainerHeight + bottomToolbarHeight;

  double get searchBarBottomPadding => 14;
  double get searchContainerHeight => searchTextFieldHeight == 0
      ? 0
      : searchTextFieldHeight + searchBarBottomPadding;
  // double get thirthToolbarHeight => largeTitleToolbarHeightx;
  // double get bottomToolbarHeight => bottomToolbarHeightx;
  // double get searchBarHeight => searchBarheightx;
  // double get primaryToolbarHeight => primaryToolbarHeightx;

  static const HeroTag defaultHeroTag = HeroTag(null);
}
