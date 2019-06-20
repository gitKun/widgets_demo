import 'package:flutter/material.dart';

import 'package:widget_demos/widgets/animated_icon_demo.dart';
import 'package:widget_demos/models/demos_options.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DemosOptions _options;

  @override
  void initState() {
    super.initState();
    _options = DemosOptions();
  }

  void _handleOptionsChanged(DemosOptions newOptions) {
    setState(() {
      if (newOptions.isAnimatedIconOpen) {
        debugPrint('AnimatedIcom is on open status!____#');
      }else {
        debugPrint('AnimatedIcom is on close status!____#');
      }
      _options = newOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CAnimatedIconWidget(
        options: _options,
        onOptionsChanged: _handleOptionsChanged,
      ),
    );
  }
}
