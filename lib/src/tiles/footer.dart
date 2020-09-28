import 'package:flutter/material.dart';

class FooterListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget leading;

  const FooterListTile({
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
