import 'package:flutter/material.dart';

class DemoTextScaleValue {
  const DemoTextScaleValue(this.scale, this.label);

  final double scale;
  final String label;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final DemoTextScaleValue typeOther = other;
    return scale == typeOther.scale && label == typeOther.label;
  }

  @override
  int get hashCode => hashValues(scale, label);

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<DemoTextScaleValue> kAllDemoTestScaleValues = <DemoTextScaleValue>[
  DemoTextScaleValue(null, 'System Default'),
  DemoTextScaleValue(0.8, 'Small'),
  DemoTextScaleValue(1.0, 'Normal'),
  DemoTextScaleValue(1.3, 'Large'),
  DemoTextScaleValue(2.0, 'Huge'),
];
