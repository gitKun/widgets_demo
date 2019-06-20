import 'package:flutter/material.dart';

class DemoTheme {
  const DemoTheme._(this.name, this.data);

  final String name;
  final ThemeData data;
}

final DemoTheme kDartDemoTheme = DemoTheme._('Dark', _buildDartTheme());

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(
      fontFamily: 'GoogleSans',
    ),
  );
}

ThemeData _buildDartTheme() {
  // Color(0xAARRGGBB) 必须保证为 8位 得 16进制
  const Color primaryColor = Color(0xFF0175c2); // 决定导航栏的颜色
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    // 深色还是浅色
    accentColorBrightness: Brightness.dark,
    // 次级颜色是深色还是浅色
    primaryColor: primaryColor,
    // 主要颜色，一般决定导航栏颜色
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: secondaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    // 指示器颜色
    toggleableActiveColor: const Color(0xFF6997DF),
    accentColor: secondaryColor,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary, // ThemeData.primaryColor
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF1E88E5),
    splashColor: const Color(0x00000000),
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary, // 这个是个枚举值,值为 ThemeData.primaryColor
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

/*

ThemeData({
  Brightness brightness,// 见下文描述
  MaterialColor primarySwatch,
  Color primaryColor,// 应用主要部分的背景颜色（工具栏，标签栏等）
  Brightness primaryColorBrightness,// primaryColor的亮度。用于确定放置在主要颜色顶部的文本和图标的颜色（例如工具栏文本）。
  Color primaryColorLight,// 较亮版本的primaryColor。
  Color primaryColorDark,// 较暗版本的primaryColor。
  Color accentColor,// 小部件的前景色（旋钮，文本，过度滚动边缘效果等）。
  Brightness accentColorBrightness,//accentColor的亮度。用于确定放置在强调颜色顶部的文本和图标的颜色（例如浮动操作按钮上的图标）。
  Color canvasColor,// MaterialType.canvas Material 的默认颜色。
  Color scaffoldBackgroundColor,// 作为 Material 脚手架的基础默认颜色。典型 Material 应用或应用内页面的背景颜色。
  Color bottomAppBarColor,// BottomAppBar的默认颜色。 这可以通过指定BottomAppBar.color来覆盖。
  Color cardColor, // Material 用作卡片时的颜色。 
  Color dividerColor,// 见下文
  Color highlightColor,// 选择墨水喷溅动画期间使用的高亮颜色或指示菜单中的项目。
  Color splashColor,// 墨水的颜色飞溅。见InkWell。
  InteractiveInkFeatureFactory splashFactory,// 见下文
  Color selectedRowColor,// 用于突出显示所选行的颜色。
  Color unselectedWidgetColor,// 用于窗口小部件处于非活动（但已启用）状态的颜色。例如，未选中的复选框。通常与accentColor形成对比。另请参见disabledColor。
  Color disabledColor,// 用于小部件的颜色，无论其状态如何都不起作用。例如，禁用复选框（可以选中或取消选中）。
  Color buttonColor,// RaisedButton中使用的 Material 的默认填充颜色。
  ButtonThemeData buttonTheme,// 定义按钮小部件的默认配置，例如RaisedButton 和FlatButton。
  Color secondaryHeaderColor,// 有选定行时 PaginatedDataTable 标题的颜色。
  Color textSelectionColor,// 文本字段中文本选择的颜色，例如TextField。
  Color cursorColor,// Material 样式文本字段中的游标颜色，例如TextField。
  Color textSelectionHandleColor,// 用于调整当前所选文本部分的句柄颜色。
  Color backgroundColor,// 与 primaryColor 形成对比的颜色，例如用作进度条的剩余部分。
  Color dialogBackgroundColor,// Dialog元素的背景颜色。
  Color indicatorColor,// 选项卡栏中所选选项卡指示器的颜色。
  Color hintColor,// 用于提示文本或占位符文本的颜色，例如在 TextField字段中。
  Color errorColor,// 用于输入验证错误的颜色，例如在TextField字段中。
  Color toggleableActiveColor,// 用于突出显示切换小部件（如Switch，Radio和Checkbox）的活动状态的颜色 。
  String fontFamily,
  TextTheme textTheme,// 文字的颜色与卡片和画布颜色形成鲜明对比。
  TextTheme primaryTextTheme,// 与 primary color 形成对比的文本主题。
  TextTheme accentTextTheme,// 与accentColor对比的文本主题。
  InputDecorationTheme inputDecorationTheme,// 见下文
  IconThemeData iconTheme,// 与卡片和画布颜色形成鲜明对比的图标主题。
  IconThemeData primaryIconTheme,// 与 primary color 形成对比的图标主题。
  IconThemeData accentIconTheme,// 与 accent color 对比的图标主题。
  SliderThemeData sliderTheme,// 用于渲染滑块的颜色和形状。 这是 SliderTheme.of 返回的值。
  TabBarTheme tabBarTheme,// 用于自定义选项卡栏指示器的大小，形状和颜色的主题。
  CardTheme cardTheme,// 用于渲染卡片的颜色和样式。 这是 CardTheme.of  返回的值。
  ChipThemeData chipTheme, //用于渲染Chip的颜色和样式， 这是ChipTheme.of返回的值。
  TargetPlatform platform,// 见下文
  MaterialTapTargetSize materialTapTargetSize,// 配置某些Material小部件的命中测试大小。
  PageTransitionsTheme pageTransitionsTheme,// 见下文
  AppBarTheme appBarTheme,// 用于自定义AppBar的颜色，高度，亮度，iconTheme和textTheme 的主题。
  BottomAppBarTheme bottomAppBarTheme,// 用于自定义BottomAppBar的形状，高程和颜色的主题。
  ColorScheme colorScheme,// 见后文详解
  DialogTheme dialogTheme,// 用于自定义对话框形状的主题。
  FloatingActionButtonThemeData floatingActionButtonTheme,// 用于自定义FloatingActionButton的形状，高程和颜色的主题 。
  Typography typography,// 用于配置textTheme， primaryTextTheme和accentTextTheme的颜色和几何TextTheme值。
  CupertinoThemeData cupertinoOverrideTheme,// 覆盖派生的 Cupertino 风格
})

* brightness: 应用程序整体主题的亮度。由按钮等小部件使用，以确定在不使用主色或强调色时要选择的颜色。 当亮度较暗时，画布，卡片和原色都是黑暗的。当亮度很亮时，画布和卡片的颜色很明亮，主色的暗度会因primaryColorBrightness的描述而变化。当亮度较暗时，primaryColor与卡片和画布颜色形成鲜明对比; 当亮度较暗时，使用Colors.white或accentColor作为对比色。

* colorScheme：: 一组13种颜色，可用于配置大多数组件的颜色属性。 此属性的添加时间远远超过主题的高度特定颜色集，如cardColor，buttonColor，canvasColor等。新组件只能根据colorScheme定义。现有组件将逐渐迁移到它，在可能的范围内没有显着的向后兼容性中断。

* dividerColor: Dividers和PopupMenuDividers的颜色，也在ListTiles之间，DataTable中的行之间使用，等等。要创建使用此颜色的适当BorderSide，请考虑 Divider.createBorderSide。

* inputDecorationTheme: InputDecorator，TextField和TextFormField的默认InputDecoration值基于此主题。 请参阅InputDecoration.applyDefaults。

* pageTransitionsTheme: 每个TargetPlatform的默认MaterialPageRoute转换。 MaterialPageRoute.buildTransitions委托给PageTransitionsBuilder 其PageTransitionsBuilder.platform相匹配的平台。如果未找到匹配的构建器，则使用其平台为null的构建器。

* platform: 材料小部件应该适应目标的平台。 默认为当前平台。这应该用于根据平台约定来设置UI元素的样式。  Platform.defaultTargetPlatform应该直接使用，而只是在极少数情况下，需要根据平台确定行为。dart.io.Platform.environment当实际知道当前平台至关重要时，应该使用它，而不需要任何覆盖（例如，当即将调用系统API时）。

* splashFactory: 定义InkWell 和InkResponse产生的墨水飞溅的外观。 也可以看看： 1.InkSplash.splashFactory，定义默认的splash。2.InkRipple.splashFactory，它定义了一个比默认值更积极地展开的splash。

 */
