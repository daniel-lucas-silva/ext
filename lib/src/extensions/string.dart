import 'package:flutter/widgets.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String ifEmpty(String value) => (this == null || this.isEmpty) ? value : this;

  Text toText([String or, TextStyle style]) => (this == null || this.isEmpty)
      ? (or == null || or.isEmpty) ? null : Text(or, style: style)
      : Text(this, style: style);
}