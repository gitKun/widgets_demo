/*
* 展示可以 AnimatedIcon
* */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/demos_animated_icon.dart';
import 'package:widget_demos/models/demos_options.dart';

class CAnimatedIconWidget extends StatefulWidget {
  const CAnimatedIconWidget({
    this.options,
    this.onOptionsChanged,
  });

  final DemosOptions options;
  final ValueChanged<DemosOptions> onOptionsChanged;

  @override
  _CAnimatedIconWidgetState createState() => _CAnimatedIconWidgetState();
}

class _CAnimatedIconWidgetState extends State<CAnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  void _handleChangeAnimated(DemosOptions newOptions) {
    // 判断是否播放动画
    if (newOptions.isAnimatedIconOpen != widget.options.isAnimatedIconOpen) {
      final AnimationStatus status = _controller.status;
      final bool isOpen = status == AnimationStatus.completed ||
          status == AnimationStatus.forward;
      _controller.fling(velocity: isOpen ? -2.0 : 2.0);
    }

    widget.onOptionsChanged(newOptions);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.primaryTextTheme.subhead,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 124.0),
        children: <Widget>[
          const _Heading('AnimatedIcons'),
          _AnimatedIconsWidget(
            // widget.options.animatedIcon,
            widget.options,
            _handleChangeAnimated,
            _controller,
          ),
        ],
      ),
    );
  }
}

class CAnimatedIconsOptions {
  CAnimatedIconsOptions({
    this.show,
  });

  final bool show;

  CAnimatedIconsOptions copyWith({
    bool show,
  }) {
    return CAnimatedIconsOptions(
      show: show ?? this.show,
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.body1.copyWith(
              fontFamily: 'GoogleSans',
              color: Theme.of(context).accentColor,
            ),
        child: Semantics(
          child: Text(title),
          header: true,
        ),
      ),
    );
  }
}

const double _kItemHeight = 48.0;
const EdgeInsetsDirectional _kItemPadding =
    EdgeInsetsDirectional.only(start: 56.0);

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(minHeight: _kItemHeight * textScaleFactor),
        padding: _kItemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child,
          ),
        ),
      ),
    );
  }
}

// class _BooleanItem extends StatelessWidget {
//   const _BooleanItem(this.title, this.value, this.onChanged, {this.switchKey});

//   final String title;
//   final bool value;
//   final ValueChanged<bool> onChanged;
//   final Key switchKey;

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return _OptionsItem(
//       child: Row(
//         children: <Widget>[
//           Expanded(child: Text(title)),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             key: switchKey,
//             activeColor: const Color(0xFF39CEFFD),
//             activeTrackColor: isDark ? Colors.white30 : Colors.black26,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _AnimatedIconsWidget extends StatelessWidget {
  const _AnimatedIconsWidget(
    this.options,
    this.onOptionsChanged,
    this.controller,
  );

  final DemosOptions options;
  final ValueChanged<DemosOptions> onOptionsChanged;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    // final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('${options.animatedIcon.name}'),
                  ],
                ),
                PopupMenuButton<DemosAnimatedIcon>(
                  padding: const EdgeInsetsDirectional.only(start: 0.0),
                  icon: const Icon(Icons.arrow_drop_down),
                  itemBuilder: (BuildContext ctx) {
                    return kAllAnimatedIconValues
                        .map<PopupMenuItem<DemosAnimatedIcon>>(
                            (DemosAnimatedIcon icon) {
                      return PopupMenuItem<DemosAnimatedIcon>(
                        value: icon,
                        child: Text(icon.name),
                      );
                    }).toList();
                  },
                  onSelected: (DemosAnimatedIcon selectedIcon) {
                    if (selectedIcon == options.animatedIcon) {
                      debugPrint('未改变AnimatedIcon图标!');
                    } else {
                      onOptionsChanged(
                        options.copyWith(animatedIcon: selectedIcon),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              onOptionsChanged(
                options.copyWith(
                    isAnimatedIconOpen: !options.isAnimatedIconOpen),
              );
            },
            splashColor: Color(0x00000000), // 水波动画的颜色，设置为透明色会有取消水波动画的效果
            highlightColor: Colors.green, // 长按后出现的高亮状态的颜色
            color: Colors.red, // 文本的颜色
            tooltip: '${options.animatedIcon.name}', // 长按后会显示的文字说明(会在高亮状态结束后显示)
            icon: AnimatedIcon(
              icon: options.animatedIcon.data,
              progress: controller,
            ),
          ),
        ],
      ),
    );
  }
}
