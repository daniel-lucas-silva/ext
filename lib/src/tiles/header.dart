import 'package:flutter/material.dart';

class HeaderListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget leading;

  const HeaderListTile({
    Key key,
    this.title,
    this.subtitle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
    );
  }
}
