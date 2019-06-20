import 'package:flutter/cupertino.dart';

import '../../gallery/demo.dart';

class CupertinoProgressIndicatorDemo extends StatelessWidget {
  static const String routeName = '/cupertino/progress_indicator';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // 在这里指定了一个back标签， 因为前面的页面是一个Material页面。
        // CupertinoPageRoutes可以自动填充这些返回标签。
        previousPageTitle: 'Cupertino',
        middle: const Text('Activity Indicator'),
        trailing: CupertinoDemoDocumentationButton(routeName),
      ),
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
