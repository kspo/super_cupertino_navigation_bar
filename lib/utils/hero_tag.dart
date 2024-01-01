import 'package:flutter/cupertino.dart';

@immutable
class HeroTag {
  const HeroTag(this.navigator);

  final NavigatorState? navigator;

  // Let the Hero tag be described in tree dumps.
  @override
  String toString() =>
      'Default Hero tag for Cupertino navigation bars with navigator $navigator';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is HeroTag && other.navigator == navigator;
  }

  @override
  int get hashCode => identityHashCode(navigator);
}
