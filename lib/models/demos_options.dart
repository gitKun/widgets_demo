import 'package:flutter/material.dart';

import 'demos_animated_icon.dart';

class DemosOptions {
  DemosOptions({
    Key key,
    this.animatedIcon = kCloseMenuIcon,
    this.isAnimatedIconOpen = false,
  });

  final DemosAnimatedIcon animatedIcon;
  final bool isAnimatedIconOpen;

  DemosOptions copyWith({
    DemosAnimatedIcon animatedIcon,
    bool isAnimatedIconOpen,
  }) {
    return DemosOptions(
      animatedIcon: animatedIcon ?? this.animatedIcon,
      isAnimatedIconOpen: isAnimatedIconOpen ?? this.isAnimatedIconOpen,
    );
  }

//  @override
//  int get hashCode => hashValues(
//      animatedIcon,
//  );
  @override
  int get hashCode => hashValues(
        animatedIcon,
        isAnimatedIconOpen,
      );

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) {
      return false;
    }
    final DemosOptions typeOther = other;
    return animatedIcon == typeOther.animatedIcon &&
        isAnimatedIconOpen == typeOther.isAnimatedIconOpen;
  }

  @override
  String toString() {
    return '$runtimeType($animatedIcon)';
  }
}
