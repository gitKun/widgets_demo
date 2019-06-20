// import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'demos.dart';

class CupertinoDemoDocumentationButton extends StatelessWidget {
  CupertinoDemoDocumentationButton(String routeName, {Key key})
      : documentationUrl = kDemoDocumentationUrl[routeName],
        assert(
          kDemoDocumentationUrl[routeName] != null,
          'A documentation URL was not specified for demo route $routeName in kAllGalleryDemos',
        ),
        super(key: key);

  final String documentationUrl;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Semantics(
        label: 'API documentation',
        child: const Icon(CupertinoIcons.book),
      ),
      onPressed: () => launch(documentationUrl, forceWebView: true),
    );
  }
}
