import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DefaultListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget detail;
  final bool isThreeLine;
  final bool checked;
  final bool disclosure;
  final VisualDensity visualDensity;
  final ShapeBorder shape;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final bool selected;
  final Color focusColor;
  final Color hoverColor;
  final FocusNode focusNode;
  final bool autofocus;
  final Color tileColor;
  final Color selectedTileColor;

  const DefaultListTile({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.visualDensity,
    this.shape,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.detail,
    this.checked = false,
    this.disclosure = false,
  }) : super(key: key);

  Widget _buildTrailing(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (detail != null)
          DefaultTextStyle(
            style: theme.textTheme.subtitle1.copyWith(
              color: isDark
                  ? Color.fromRGBO(235, 235, 245, 0.6)
                  : Color(0xFF222222),
            ),
            child: detail,
          ),
        if (onTap != null && detail != null) SizedBox(width: 10),
        if (onTap != null)
          Icon(
            Icons.chevron_right,
            color:
                isDark ? Color.fromRGBO(235, 235, 245, 0.6) : Color(0xFF222222),
          )
        else if (trailing != null)
          trailing,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      dense: false,
      onTap: onTap,
      trailing: _buildTrailing(context),
      contentPadding: contentPadding,
      enabled: enabled,
      isThreeLine: isThreeLine,
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}
