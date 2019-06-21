import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_gallery/demo/shrine/model/app_state_model.dart';
import 'options.dart';
import 'updater.dart';
import 'home.dart';
import 'demos.dart';
import 'themes.dart';
import 'scales.dart';

class GalleryApp extends StatefulWidget {
  const GalleryApp({
    Key key,
    this.updateUrlFetcher,
    this.enablePerformanceOverlay = true,
    this.enableRasterCacheImagesCheckerboard = true,
    this.enableOffscreenLayersCheckerboard = true,
    this.onSendFeedback,
    this.testMode = false,
  }) : super(key: key);

  final UpdateUrlFetcher updateUrlFetcher;
  final bool enablePerformanceOverlay;
  final bool enableRasterCacheImagesCheckerboard;
  final bool enableOffscreenLayersCheckerboard;
  final VoidCallback onSendFeedback;
  final bool testMode;

  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  GalleryOptions _options;
  Timer _timeDilationTimer;
  AppStateModel model;

  Map<String, WidgetBuilder> _buildRoutes() {
    /*
    对于如何使用命名路由设置应用程序路由表的另一个示例，
    请考虑Navigator类文档中的示例:
    https://docs.flutter.io/flutter/widgets/Navigator-class.html
    */
    return Map<String, WidgetBuilder>.fromIterable(
      kAllGalleryDemos,
      key: (dynamic demo) => '${demo.routeName}',
      value: (dynamic demo) => demo.buildRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    _options = GalleryOptions(
      theme: kLightGalleryTheme,
      textScaleFactor: kAllGalleryTextScaleValues[0],
      timeDilation: timeDilation,
      platform: defaultTargetPlatform,
    );
    model = AppStateModel()..loadProducts();
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  void _handleOptionsChanged(GalleryOptions newOptions) {
    setState(() {
      if (_options.timeDilation != newOptions.timeDilation) {
        _timeDilationTimer?.cancel();
        _timeDilationTimer = null;
        if (newOptions.timeDilation > 1.0) {
          /*
          我们延迟时间膨胀的变化足够长，让用户看到UI已经开始反应，
          然后我们猛踩刹车，让他们看到时间实际上已经膨胀。
           */
          _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
            timeDilation = newOptions.timeDilation;
          });
        } else {
          timeDilation = newOptions.timeDilation;
        }
      }

      _options = newOptions;
    });
  }

  Widget _applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _options.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget home = GalleryHome(
      testMode: widget.testMode,
      optionsPage: GalleryOptionsPage(
        options: _options,
        onOptionsChanged: _handleOptionsChanged,
        onSendFeedback: widget.onSendFeedback ??
            () {
              launch('https://github.com/flutter/flutter/issues/new/choose',
                  forceSafariVC: false);
            },
      ),
    );

    if (widget.updateUrlFetcher != null) {
      home = Updater(
        updateUrlFetcher: widget.updateUrlFetcher,
        child: home,
      );
    }

    return ScopedModel<AppStateModel>(
      model: model,
      child: MaterialApp(
        theme: _options.theme.data.copyWith(platform: _options.platform),
        title: 'Flutter Gallery',
        color: Colors.grey,
        showPerformanceOverlay: _options.showPerformanceOverlay,
        checkerboardOffscreenLayers: _options.showOffscreenLayersCheckerboard,
        checkerboardRasterCacheImages:
            _options.showRasterCacheImagesCheckerboard,
        routes: _buildRoutes(),
        builder: (BuildContext context, Widget child) {
          return Directionality(
            textDirection: _options.textDirection,
            child: _applyTextScaleFactor(
              /*
              在这里使用一个空白的CupertinoTheme，
              除了显示标准iOS外观的亮度外，不要过渡到 Material 的原色等。
              */
              CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: _options.theme.data.brightness,
                ),
                child: child,
              ),
            ),
          );
        },
        home: home,
      ),
    );
  }
}
