import 'package:flutter/widgets.dart';

typedef SaveCallback = bool Function();
typedef FormWidgetBuilder = Widget Function(
  BuildContext context,
  SaveCallback save,
  VoidCallback reset,
);

class FormBuilder extends StatefulWidget {
  final FormWidgetBuilder builder;
  final VoidCallback onChanged;
  final VoidCallback onSaved;
  final AutovalidateMode autovalidateMode;

  FormBuilder({
    Key key,
    this.builder,
    this.onChanged,
    this.onSaved,
    this.autovalidateMode: AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _validateSave() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (widget.onSaved != null) widget.onSaved();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      child: Builder(
        builder: (context) {
          return widget.builder(
            context,
            _validateSave,
            _key.currentState.reset,
          );
        },
      ),
    );
  }
}
