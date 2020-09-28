import 'package:flutter/material.dart';

class SwitchFormField extends FormField<bool> {
  SwitchFormField({
    Key key,
    bool value,
    Widget hint,
    @required this.onChanged,
    VoidCallback onTap,
    this.decoration = const InputDecoration(),
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool autoValidate = false,
    Widget disabledHint,
    int elevation = 8,
    TextStyle style,
    Widget icon,
    Color iconDisabledColor,
    Color iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double itemHeight,
  }) :
        assert(decoration != null),
        assert(elevation != null),
        assert(iconSize != null),
        assert(isDense != null),
        assert(isExpanded != null),
        assert(itemHeight == null || itemHeight > 0),
        super(
        key: key,
        onSaved: onSaved,
        initialValue: value,
        validator: validator,
        autovalidate: autoValidate,
        builder: (FormFieldState<bool> field) {
          final _SwitchFormFieldState state = field as _SwitchFormFieldState;
          final InputDecoration effectiveDecoration = decoration.applyDefaults(
            Theme.of(field.context).inputDecorationTheme,
          );
          return InputDecorator(
            decoration: effectiveDecoration.copyWith(errorText: field.errorText),
            isEmpty: state.value == null,
            child: Offstage(),
          );
        },
      );

  final ValueChanged<bool> onChanged;
  final InputDecoration decoration;

  @override
  FormFieldState<bool> createState() => _SwitchFormFieldState();
}

class _SwitchFormFieldState extends FormFieldState<bool> {
  @override
  SwitchFormField get widget => super.widget as SwitchFormField;

  @override
  void didChange(bool value) {
    super.didChange(value);
    assert(widget.onChanged != null);
    widget.onChanged(value);
  }

  @override
  void didUpdateWidget(SwitchFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}