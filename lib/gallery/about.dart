import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkTextSpan extends TextSpan {
  /*
   * 小心!
   * 这个类之所以安全，是因为TapGestureRecognizer没有给出一个截止日期，因此从不分配任何资源。
   * 在任何其他情况下——设置截止日期、使用任何较小的识别器，
   * 等等——您都必须管理手势识别器的生存期，并在不再呈现TextSpan时调用dispose()。
   * 由于TextSpan本身是@不可变的，这意味着您必须从TextSpan外部管理识别器，
   * 例如，在有状态小部件的状态中，然后将识别器交给TextSpan。
  */

  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(url, forceSafariVC: false);
              });
}

void showGalleryAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.body2;
  final TextStyle linkStyle =
      themeData.textTheme.body2.copyWith(color: themeData.accentColor);

  showAboutDialog(
    context: context,
    applicationVersion: 'January 2019',
    applicationIcon: const FlutterLogo(),
    applicationLegalese: '© 2019 The Chromium Authors',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'Flutter is an open-source project to help developers '
                    'build high-performance, high-fidelity, mobile apps for '
                    '${defaultTargetPlatform == TargetPlatform.iOS ? 'multiple platforms' : 'iOS and Android'}'
                    'from a single codebase. This design lab is a playground '
                    "and showcase of Flutter's many widgets, behaviors, "
                    'animations, layouts, and more. Learn more about Flutter at ',
              ),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://flutter-io.cn/docs',
              ),
              TextSpan(
                  style: aboutTextStyle,
                  text:
                      '.\n\nTo see the source code for this app, please visit the '),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://goo.gl/iv1q4G',
                text: 'flutter github repo',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
