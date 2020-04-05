import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gallery/app.dart';
// import 'github_app/app.dart';

void main() {
  // runApp(const GalleryApp());
  runZoned(
    () {
      runApp(const GalleryApp());
      PaintingBinding.instance.imageCache.maximumSize = 100;
      Provider.debugCheckInvalidValueType = null;
    },
    onError: (Object obj, StackTrace stack) {
      print(obj);
      print(stack);
    },
  );
}
