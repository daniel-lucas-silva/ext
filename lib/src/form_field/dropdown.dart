import 'package:flutter/material.dart';

class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    Key key,
    T value,
    @required List<DropdownMenuItem<T>> items,
    DropdownButtonBuilder selectedItemBuilder,
    Widget hint,
    @required this.onChanged,
    VoidCallback onTap,
    this.decoration = const InputDecoration(),
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
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
  }) : assert(items == null || items.isEmpty || value == null ||
      items.where((DropdownMenuItem<T> item) {
        return item.value == value;
      }).length == 1,
  "There should be exactly one item with [DropdownButton]'s value: "
      '$value. \n'
      'Either zero or 2 or more [DropdownMenuItem]s were detected '
      'with the same value',
  ),
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
        builder: (FormFieldState<T> field) {
          final _DropdownFormFieldState<T> state = field as _DropdownFormFieldState<T>;
          final InputDecoration effectiveDecoration = decoration.applyDefaults(
            Theme.of(field.context).inputDecorationTheme,
          );
          return InputDecorator(
            decoration: effectiveDecoration.copyWith(errorText: field.errorText),
            isEmpty: state.value == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: state.value,
                items: items,
                selectedItemBuilder: selectedItemBuilder,
                hint: hint,
                onChanged: onChanged == null ? null : state.didChange,
                onTap: onTap,
                disabledHint: disabledHint,
                elevation: elevation,
                style: style,
                icon: icon,
                iconDisabledColor: iconDisabledColor,
                iconEnabledColor: iconEnabledColor,
                iconSize: iconSize,
                isDense: isDense,
                isExpanded: isExpanded,
                itemHeight: itemHeight,
              ),
            ),
          );
        },
      );

  final ValueChanged<T> onChanged;
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _DropdownFormFieldState<T>();
}

class _DropdownFormFieldState<T> extends FormFieldState<T> {
  @override
  DropdownFormField<T> get widget => super.widget as DropdownFormField<T>;

  @override
  void didChange(T value) {
    super.didChange(value);
    assert(widget.onChanged != null);
    widget.onChanged(value);
  }

  @override
  void didUpdateWidget(DropdownFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}