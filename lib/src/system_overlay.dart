import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemOverlay extends StatelessWidget {
  final Widget child;
  final bool hasNavigationBar;

  const SystemOverlay({
    Key key,
    @required this.child,
    this.hasNavigationBar: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final systemNavigationBarColor = theme.scaffoldBackgroundColor;

    final isDark = systemNavigationBarColor.computeLuminance() < 5.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: child,
    );
  }
}
