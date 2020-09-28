import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:flutter/src/material/pickers/date_picker_header.dart';
import 'package:flutter/src/material/pickers/date_utils.dart' as utils;

import 'date_picker_calendar.dart';

const Size _calendarPortraitDialogSize = Size(330.0, 518.0);
const Size _calendarLandscapeDialogSize = Size(496.0, 346.0);
const Size _inputPortraitDialogSize = Size(330.0, 270.0);
const Size _inputLandscapeDialogSize = Size(496, 160.0);
const Duration _dialogSizeAnimationDuration = Duration(milliseconds: 200);

Future<DateTime> showDatePicker({
  @required BuildContext context,
  @required DateTime initialDate,
  @required DateTime firstDate,
  @required DateTime lastDate,
  DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  SelectableDayPredicate selectableDayPredicate,
  String helpText,
  String cancelText,
  String confirmText,
  Locale locale,
  bool useRootNavigator = true,
  RouteSettings routeSettings,
  TextDirection textDirection,
  TransitionBuilder builder,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  String errorFormatText,
  String errorInvalidText,
  String fieldHintText,
  String fieldLabelText,
}) async {
  assert(context != null);
  assert(initialDate != null);
  assert(firstDate != null);
  assert(lastDate != null);
  initialDate = utils.dateOnly(initialDate);
  firstDate = utils.dateOnly(firstDate);
  lastDate = utils.dateOnly(lastDate);
  assert(!lastDate.isBefore(firstDate),
      'lastDate $lastDate must be on or after firstDate $firstDate.');
  assert(!initialDate.isBefore(firstDate),
      'initialDate $initialDate must be on or after firstDate $firstDate.');
  assert(!initialDate.isAfter(lastDate),
      'initialDate $initialDate must be on or before lastDate $lastDate.');
  assert(selectableDayPredicate == null || selectableDayPredicate(initialDate),
      'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.');
  assert(initialEntryMode != null);
  assert(useRootNavigator != null);
  assert(initialDatePickerMode != null);
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = DatePicker(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    initialEntryMode: initialEntryMode,
    selectableDayPredicate: selectableDayPredicate,
    helpText: helpText,
    cancelText: cancelText,
    confirmText: confirmText,
    initialCalendarMode: initialDatePickerMode,
    errorFormatText: errorFormatText,
    errorInvalidText: errorInvalidText,
    fieldHintText: fieldHintText,
    fieldLabelText: fieldLabelText,
  );

  if (textDirection != null) {
    dialog = Directionality(
      textDirection: textDirection,
      child: dialog,
    );
  }

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
  }

  return showDialog<DateTime>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}

class DatePicker extends StatefulWidget {
  DatePicker({
    Key key,
    @required DateTime initialDate,
    @required DateTime firstDate,
    @required DateTime lastDate,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.selectableDayPredicate,
    this.cancelText,
    this.confirmText,
    this.helpText,
    this.initialCalendarMode = DatePickerMode.day,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
  })  : assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        initialDate = utils.dateOnly(initialDate),
        firstDate = utils.dateOnly(firstDate),
        lastDate = utils.dateOnly(lastDate),
        assert(initialEntryMode != null),
        assert(initialCalendarMode != null),
        super(key: key) {
    assert(!this.lastDate.isBefore(this.firstDate),
        'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.');
    assert(!this.initialDate.isBefore(this.firstDate),
        'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.');
    assert(!this.initialDate.isAfter(this.lastDate),
        'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.');
    assert(
        selectableDayPredicate == null ||
            selectableDayPredicate(this.initialDate),
        'Provided initialDate ${this.initialDate} must satisfy provided selectableDayPredicate');
  }

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DatePickerEntryMode initialEntryMode;
  final SelectableDayPredicate selectableDayPredicate;
  final String cancelText;
  final String confirmText;
  final String helpText;
  final DatePickerMode initialCalendarMode;
  final String errorFormatText;
  final String errorInvalidText;
  final String fieldHintText;
  final String fieldLabelText;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DatePickerEntryMode _entryMode;
  DateTime _selectedDate;
  bool _autoValidate;
  final GlobalKey _calendarPickerKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _entryMode = widget.initialEntryMode;
    _selectedDate = widget.initialDate;
    _autoValidate = false;
  }

  void _handleOk() {
    if (_entryMode == DatePickerEntryMode.input) {
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        setState(() => _autoValidate = true);
        return;
      }
      form.save();
    }
    Navigator.pop(context, _selectedDate);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handelEntryModeToggle() {
    setState(() {
      switch (_entryMode) {
        case DatePickerEntryMode.calendar:
          _autoValidate = false;
          _entryMode = DatePickerEntryMode.input;
          break;
        case DatePickerEntryMode.input:
          _formKey.currentState.save();
          _entryMode = DatePickerEntryMode.calendar;
          break;
      }
    });
  }

  void _handleDateChanged(DateTime date) {
    setState(() => _selectedDate = date);
  }

  Size _dialogSize(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    switch (_entryMode) {
      case DatePickerEntryMode.calendar:
        switch (orientation) {
          case Orientation.portrait:
            return _calendarPortraitDialogSize;
          case Orientation.landscape:
            return _calendarLandscapeDialogSize;
        }
        break;
      case DatePickerEntryMode.input:
        switch (orientation) {
          case Orientation.portrait:
            return _inputPortraitDialogSize;
          case Orientation.landscape:
            return _inputLandscapeDialogSize;
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    final TextTheme textTheme = theme.textTheme;

    final double textScaleFactor =
        math.min(MediaQuery.of(context).textScaleFactor, 1.3);

    final String dateText = _selectedDate != null
        ? localizations.formatMediumDate(_selectedDate)
        : 'Date';
    final Color dateColor = colorScheme.brightness == Brightness.light
        ? colorScheme.onPrimary
        : colorScheme.onSurface;
    final TextStyle dateStyle = orientation == Orientation.landscape
        ? textTheme.headline5?.copyWith(color: dateColor)
        : textTheme.headline4?.copyWith(color: dateColor);

    final Widget actions = ButtonBar(
      buttonTextTheme: ButtonTextTheme.primary,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: <Widget>[
        FlatButton(
          child: Text(widget.cancelText ?? localizations.cancelButtonLabel),
          onPressed: _handleCancel,
        ),
        FlatButton(
          child: Text(widget.confirmText ?? localizations.okButtonLabel),
          onPressed: _handleOk,
        ),
      ],
    );

    Widget picker;
    IconData entryModeIcon;
    String entryModeTooltip;
    switch (_entryMode) {
      case DatePickerEntryMode.calendar:
        picker = CalendarDatePicker(
          key: _calendarPickerKey,
          initialDate: _selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          onDateChanged: _handleDateChanged,
          selectableDayPredicate: widget.selectableDayPredicate,
          initialCalendarMode: widget.initialCalendarMode,
        );
        entryModeIcon = Icons.edit;

        entryModeTooltip = 'Switch to input';
        break;

      case DatePickerEntryMode.input:
        picker = Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: InputDatePickerFormField(
            initialDate: _selectedDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            onDateSubmitted: _handleDateChanged,
            onDateSaved: _handleDateChanged,
            selectableDayPredicate: widget.selectableDayPredicate,
            errorFormatText: widget.errorFormatText,
            errorInvalidText: widget.errorInvalidText,
            fieldHintText: widget.fieldHintText,
            fieldLabelText: widget.fieldLabelText,
            autofocus: true,
          ),
        );
        entryModeIcon = Icons.calendar_today;

        entryModeTooltip = 'Switch to calendar';
        break;
    }

    final Widget header = DatePickerHeader(
      helpText: widget.helpText ?? 'SELECT DATE',
      titleText: dateText,
      titleStyle: dateStyle,
      orientation: orientation,
      isShort: orientation == Orientation.landscape,
      icon: entryModeIcon,
      iconTooltip: entryModeTooltip,
      onIconPressed: _handelEntryModeToggle,
    );

    final Size dialogSize = _dialogSize(context) * textScaleFactor;
    final DialogTheme dialogTheme = Theme.of(context).dialogTheme;
    return Dialog(
      child: AnimatedContainer(
        width: dialogSize.width,
        height: dialogSize.height,
        duration: _dialogSizeAnimationDuration,
        curve: Curves.easeIn,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: Builder(builder: (BuildContext context) {
            switch (orientation) {
              case Orientation.portrait:
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    header,
                    Expanded(child: picker),
                    actions,
                  ],
                );
              case Orientation.landscape:
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    header,
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(child: picker),
                          actions,
                        ],
                      ),
                    ),
                  ],
                );
            }
            return null;
          }),
        ),
      ),
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      shape: dialogTheme.shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
      clipBehavior: Clip.antiAlias,
    );
  }
}
