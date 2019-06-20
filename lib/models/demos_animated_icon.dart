import 'package:flutter/material.dart';

class DemosAnimatedIcon {
  const DemosAnimatedIcon._(this.name, this.data);

  final String name;
  final AnimatedIconData data;

  @override
  int get hashCode => hashValues(name, data.hashCode);

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) {
      return false;
    }
    final DemosAnimatedIcon typeOther = other;
    return name == typeOther.name && data == typeOther.data;
  }

  @override
  String toString() {
    return '$runtimeType($name)';
  }
}

const DemosAnimatedIcon kCloseMenuIcon =
    DemosAnimatedIcon._('close_menu', AnimatedIcons.close_menu);

const List<DemosAnimatedIcon> kAllAnimatedIconValues = <DemosAnimatedIcon>[
  DemosAnimatedIcon._('close_menu', AnimatedIcons.close_menu),
  DemosAnimatedIcon._('arrow_menu', AnimatedIcons.arrow_menu),
  DemosAnimatedIcon._('add_event', AnimatedIcons.add_event),
  DemosAnimatedIcon._('ellipsis_search', AnimatedIcons.ellipsis_search),
  DemosAnimatedIcon._('home_menu', AnimatedIcons.home_menu),
  DemosAnimatedIcon._('list_view', AnimatedIcons.list_view),
  DemosAnimatedIcon._('pause_play', AnimatedIcons.pause_play),
];
