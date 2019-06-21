// import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'demos.dart';
// import 'example_code_parser.dart';
// import 'syntax_highligter.dart';

class ComponentDemoTabData {
  ComponentDemoTabData({
    this.demoWidget,
    this.exampleCodeTag,
    this.description,
    this.tabName,
    this.documentationUrl,
  });

  final Widget demoWidget;
  final String exampleCodeTag;
  final String description;
  final String tabName;
  final String documentationUrl;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ComponentDemoTabData typeOther = other;
    return typeOther.tabName == tabName &&
        typeOther.description == description &&
        typeOther.documentationUrl == documentationUrl;
  }

  @override
  int get hashCode => hashValues(tabName, description, documentationUrl);
}

// class TabbedComponentDemoScaffold extends StatelessWidget {
//   const TabbedComponentDemoScaffold({
//     this.title,
//     this.demos,
//     this.actions,
//   });

//   final List<ComponentDemoTabData> demos;
//   final String title;
//   final List<Widget> actions;

//   void _showExampleCode(BuildContext context) {
//     final String tag =
//         demos[DefaultTabController.of(context).index].exampleCodeTag;
//     if (tag != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute<FullScreenCodeDialog>(
//           builder: (BuildContext ctx) => FullScreenCodeDialog(
//             exampleCodeTag: tag,
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> _showApiDocumentation(BuildContext context) async {
//     final String url =
//         demos[DefaultTabController.of(context).index].documentationUrl;
//     if (url == null) return;
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       showDialog<void>(
//         context: context,
//         builder: (BuildContext ctx) {
//           return SimpleDialog(
//             title: const Text('Couldn\'t display URL:'),
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(url),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: demos.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//           actions: (actions ?? <Widget>[])
//             ..addAll(
//               <Widget>[
//                 Builder(
//                   builder: (BuildContext ctx) {
//                     return IconButton(
//                         icon: const Icon(
//                           Icons.library_books,
//                           color: Colors.red,
//                           semanticLabel: 'Show documentation',
//                         ),
//                         onPressed: () => _showApiDocumentation(ctx));
//                   },
//                 ),
//                 Builder(
//                   builder: (BuildContext ctx) {
//                     return IconButton(
//                       icon: Icon(Icons.code),
//                       tooltip: 'Show example code',
//                       onPressed: () => _showExampleCode(ctx),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           bottom: TabBar(
//             tabs: demos
//                 .map<Widget>((ComponentDemoTabData data) => Tab(
//                       text: data.tabName,
//                     ))
//                 .toList(),
//             isScrollable: true,
//           ),
//         ),
//         body: TabBarView(
//           children: demos.map<Widget>(
//             (ComponentDemoTabData data) {
//               return SafeArea(
//                 top: false,
//                 bottom: false,
//                 child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         data.description,
//                         style: Theme.of(context).textTheme.subhead,
//                       ),
//                     ),
//                     Expanded(child: data.demoWidget),
//                   ],
//                 ),
//               );
//             },
//           ).toList(),
//         ),
//       ),
//     );
//   }
// }

// class FullScreenCodeDialog extends StatefulWidget {
//   const FullScreenCodeDialog({this.exampleCodeTag});

//   final String exampleCodeTag;

//   @override
//   _FullScreenCodeDialogState createState() => _FullScreenCodeDialogState();
// }

// class _FullScreenCodeDialogState extends State<FullScreenCodeDialog> {
//   String _exampleCode;

//   @override
//   void didChangeDependencies() {
//     getExampleCode(widget.exampleCodeTag, DefaultAssetBundle.of(context))
//         .then<void>((String code) {
//       if (mounted) {
//         setState(() {
//           _exampleCode = code ?? 'Example code not found';
//         });
//       }
//     });
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final SyntaxHighlighterStyle style =
//         Theme.of(context).brightness == Brightness.dark
//             ? SyntaxHighlighterStyle.darkThemeStyle()
//             : SyntaxHighlighterStyle.lightThemeStyle();
//     Widget body;
//     if (_exampleCode == null) {
//       body = const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       body = SingleChildScrollView(
//         child: RichText(
//           text: TextSpan(
//             style: const TextStyle(fontFamily: 'monospace', fontSize: 10.0),
//             children: <TextSpan>[
//               DartSyntaxHighlighter(style).format(_exampleCode),
//             ],
//           ),
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.clear,
//             semanticLabel: 'Close',
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('Example code'),
//       ),
//       body: body,
//     );
//   }
// }

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
