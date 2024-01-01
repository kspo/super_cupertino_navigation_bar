import 'package:flutter/cupertino.dart';

class Store {
  static Store? _instance;

  static Store get instance {
    _instance ??= Store._init();

    return _instance!;
  }

  Store._init();

  ///true if appBar is collapsed else false
  final ValueNotifier<bool> searchBarHasFocus = ValueNotifier(false);
  final ValueNotifier<bool> searchBarResultVisible = ValueNotifier(false);
  final ValueNotifier<SearchBarAnimationStatus> searchBarAnimationStatus =
      ValueNotifier(SearchBarAnimationStatus.paused);
  final ValueNotifier<double> scrollOffset = ValueNotifier<double>(0);
}

enum SearchBarAnimationStatus { started, onGoing, paused }
