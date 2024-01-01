import 'package:flutter/material.dart';

import 'hero_tag.dart';

class Measures {
  static Measures? _instance;

  static Measures get instance {
    _instance ??= Measures();

    return _instance!;
  }

  Measures({
    this.searchBarheightx = 35.0,
    this.largeTitleToolbarHeightx = kToolbarHeight,
    this.primaryToolbarHeightx = kToolbarHeight,
    this.bottomToolbarHeightx = 35.0,
    this.searchBarAnimationDurationx = const Duration(milliseconds: 250),
  }) {
    searchBarheightx = searchBarheightx;
    largeTitleToolbarHeightx = largeTitleToolbarHeightx;
    primaryToolbarHeightx = primaryToolbarHeightx;
    bottomToolbarHeightx = bottomToolbarHeightx;
    searchBarAnimationDurationx = searchBarAnimationDurationx;
  }
  double largeTitleToolbarHeightx,
      primaryToolbarHeightx,
      searchBarheightx,
      bottomToolbarHeightx;
  Duration searchBarAnimationDurationx;
  Duration get titleOpacityAnimationDuration =>
      const Duration(milliseconds: 100);
  Duration get standartAnimationDuration => const Duration(milliseconds: 200);
  Duration get scrollAnimationDuration => const Duration(milliseconds: 300);
  Duration get searchBarAnimationDuration => searchBarAnimationDurationx;

  double get appbarHeight =>
      primaryToolbarHeight +
      secondaryToolbarHeight +
      thirthToolbarHeight +
      bottomToolbarHeight;

  double get appbarHeightExceptPrimaryToolbar =>
      secondaryToolbarHeight + thirthToolbarHeight + bottomToolbarHeight;

  double get searchBarHeight => searchBarheightx;
  double get primaryToolbarHeight => primaryToolbarHeightx;
  double get searchBarBottomPadding => 14;
  double get secondaryToolbarHeight =>
      searchBarHeight == 0 ? 0 : searchBarHeight + searchBarBottomPadding;
  double get thirthToolbarHeight => largeTitleToolbarHeightx;
  double get bottomToolbarHeight => bottomToolbarHeightx;

  static const HeroTag defaultHeroTag = HeroTag(null);
}
