import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  })  : assert(height == null || height >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color color;

  static BorderSide createBorderSide(BuildContext context,
      {Color color, double width}) {
    return BorderSide(
      color: color,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = this.height ?? 8.0;
    final double thickness = this.thickness ?? 8.0;
    final double indent = this.indent ?? 0.0;
    final double endIndent = this.endIndent ?? 0.0;
    final Color color = Theme.of(context).brightness == Brightness.dark
        ? Color(0xFF171717)
        : Color(0xFFF2F2F2);
    final Color effectiveColor = this.color ?? color;

    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          decoration: BoxDecoration(
            border: Border(
              bottom: createBorderSide(
                context,
                color: effectiveColor,
                width: thickness,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
