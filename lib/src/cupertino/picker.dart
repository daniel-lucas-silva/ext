import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

const Color _kHighlighterBorder = Color(0xFF7F7F7F);
const Color _kDefaultBackground = Color(0xFFD2D4DB);

const double _kDefaultDiameterRatio = 1.07;
const double _kDefaultPerspective = 0.003;
const double _kSqueeze = 1.45;

const double _kForegroundScreenOpacityFraction = 0.7;

class Picker extends StatefulWidget {
  Picker({
    Key key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor = _kDefaultBackground,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollController,
    this.squeeze = _kSqueeze,
    @required this.itemExtent,
    @required this.onSelectedItemChanged,
    @required List<Widget> children,
    bool looping = false,
  })  : assert(children != null),
        assert(diameterRatio != null),
        assert(diameterRatio > 0.0,
        RenderListWheelViewport.diameterRatioZeroMessage),
        assert(magnification > 0),
        assert(itemExtent != null),
        assert(itemExtent > 0),
        assert(squeeze != null),
        assert(squeeze > 0),
        childDelegate = looping
            ? ListWheelChildLoopingListDelegate(children: children)
            : ListWheelChildListDelegate(children: children),
        super(key: key);

  Picker.builder({
    Key key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor = _kDefaultBackground,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollController,
    this.squeeze = _kSqueeze,
    @required this.itemExtent,
    @required this.onSelectedItemChanged,
    @required IndexedWidgetBuilder itemBuilder,
    int childCount,
  })  : assert(itemBuilder != null),
        assert(diameterRatio != null),
        assert(diameterRatio > 0.0,
        RenderListWheelViewport.diameterRatioZeroMessage),
        assert(magnification > 0),
        assert(itemExtent != null),
        assert(itemExtent > 0),
        assert(squeeze != null),
        assert(squeeze > 0),
        childDelegate = ListWheelChildBuilderDelegate(
            builder: itemBuilder, childCount: childCount),
        super(key: key);

  final double diameterRatio;
  final Color backgroundColor;
  final double offAxisFraction;
  final bool useMagnifier;
  final double magnification;
  final FixedExtentScrollController scrollController;
  final double itemExtent;
  final double squeeze;
  final ValueChanged<int> onSelectedItemChanged;
  final ListWheelChildDelegate childDelegate;

  @override
  State<StatefulWidget> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  int _lastHapticIndex;
  FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _controller = FixedExtentScrollController();
    }
  }

  @override
  void didUpdateWidget(Picker oldWidget) {
    if (widget.scrollController != null && oldWidget.scrollController == null) {
      _controller = null;
    } else if (widget.scrollController == null &&
        oldWidget.scrollController != null) {
      assert(_controller == null);
      _controller = FixedExtentScrollController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleSelectedItemChanged(int index) {
    bool hasSuitableHapticHardware;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        hasSuitableHapticHardware = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.macOS:
        hasSuitableHapticHardware = false;
        break;
    }
    assert(hasSuitableHapticHardware != null);
    if (hasSuitableHapticHardware && index != _lastHapticIndex) {
      _lastHapticIndex = index;
      HapticFeedback.selectionClick();
    }

    if (widget.onSelectedItemChanged != null) {
      widget.onSelectedItemChanged(index);
    }
  }

  Widget _buildGradientScreen() {
    if (widget.backgroundColor != null && widget.backgroundColor.alpha < 255)
      return Container();

    final Color widgetBackgroundColor =
        widget.backgroundColor ?? const Color(0xFFFFFFFF);
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                widgetBackgroundColor,
                widgetBackgroundColor.withAlpha(0xF2),
                widgetBackgroundColor.withAlpha(0xDD),
                widgetBackgroundColor.withAlpha(0),
                widgetBackgroundColor.withAlpha(0),
                widgetBackgroundColor.withAlpha(0xDD),
                widgetBackgroundColor.withAlpha(0xF2),
                widgetBackgroundColor,
              ],
              stops: const <double>[
                0.0,
                0.05,
                0.09,
                0.22,
                0.78,
                0.91,
                0.95,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMagnifierScreen() {
    final Color foreground = widget.backgroundColor?.withAlpha(
        (widget.backgroundColor.alpha * _kForegroundScreenOpacityFraction)
            .toInt());

    return IgnorePointer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: foreground,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.0, color: _kHighlighterBorder),
                bottom: BorderSide(width: 0.0, color: _kHighlighterBorder),
              ),
            ),
            constraints: BoxConstraints.expand(
              height: widget.itemExtent * widget.magnification,
            ),
          ),
          Expanded(
            child: Container(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnderMagnifierScreen() {
    final Color foreground = widget.backgroundColor?.withAlpha(
        (widget.backgroundColor.alpha * _kForegroundScreenOpacityFraction)
            .toInt());

    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Container(
          color: foreground,
          constraints: BoxConstraints.expand(
            height: widget.itemExtent * widget.magnification,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _addBackgroundToChild(Widget child) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget result = DefaultTextStyle(
      style: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Display',
        fontSize: 21.0,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
        color: Theme.of(context).textTheme.bodyText1.color,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: _PickerSemantics(
              scrollController: widget.scrollController ?? _controller,
              child: ListWheelScrollView.useDelegate(
                controller: widget.scrollController ?? _controller,
                physics: const FixedExtentScrollPhysics(),
                diameterRatio: widget.diameterRatio,
                perspective: _kDefaultPerspective,
                offAxisFraction: widget.offAxisFraction,
                useMagnifier: widget.useMagnifier,
                magnification: widget.magnification,
                itemExtent: widget.itemExtent,
                squeeze: widget.squeeze,
                onSelectedItemChanged: _handleSelectedItemChanged,
                childDelegate: widget.childDelegate,
              ),
            ),
          ),
          _buildGradientScreen(),
          _buildMagnifierScreen(),
        ],
      ),
    );

    if (widget.backgroundColor != null && widget.backgroundColor.alpha < 255) {
      result = Stack(
        children: <Widget>[
          _buildUnderMagnifierScreen(),
          _addBackgroundToChild(result),
        ],
      );
    } else {
      result = _addBackgroundToChild(result);
    }
    return result;
  }
}

class _PickerSemantics extends SingleChildRenderObjectWidget {
  const _PickerSemantics({
    Key key,
    Widget child,
    @required this.scrollController,
  }) : super(key: key, child: child);

  final FixedExtentScrollController scrollController;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderPickerSemantics(
          scrollController, Directionality.of(context));

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderPickerSemantics renderObject) {
    renderObject
      ..textDirection = Directionality.of(context)
      ..controller = scrollController;
  }
}

class _RenderPickerSemantics extends RenderProxyBox {
  _RenderPickerSemantics(
      FixedExtentScrollController controller, this._textDirection) {
    this.controller = controller;
  }

  FixedExtentScrollController get controller => _controller;
  FixedExtentScrollController _controller;

  set controller(FixedExtentScrollController value) {
    if (value == _controller) return;
    if (_controller != null)
      _controller.removeListener(_handleScrollUpdate);
    else
      _currentIndex = value.initialItem ?? 0;
    value.addListener(_handleScrollUpdate);
    _controller = value;
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;

  set textDirection(TextDirection value) {
    if (textDirection == value) return;
    _textDirection = value;
    markNeedsSemanticsUpdate();
  }

  int _currentIndex = 0;

  void _handleIncrease() {
    controller.jumpToItem(_currentIndex + 1);
  }

  void _handleDecrease() {
    if (_currentIndex == 0) return;
    controller.jumpToItem(_currentIndex - 1);
  }

  void _handleScrollUpdate() {
    if (controller.selectedItem == _currentIndex) return;
    _currentIndex = controller.selectedItem;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
    config.textDirection = textDirection;
  }

  @override
  void assembleSemanticsNode(SemanticsNode node, SemanticsConfiguration config,
      Iterable<SemanticsNode> children) {
    if (children.isEmpty)
      return super.assembleSemanticsNode(node, config, children);
    final SemanticsNode scrollable = children.first;
    final Map<int, SemanticsNode> indexedChildren = <int, SemanticsNode>{};
    scrollable.visitChildren((SemanticsNode child) {
      assert(child.indexInParent != null);
      indexedChildren[child.indexInParent] = child;
      return true;
    });
    if (indexedChildren[_currentIndex] == null) {
      return node.updateWith(config: config);
    }
    config.value = indexedChildren[_currentIndex].label;
    final SemanticsNode previousChild = indexedChildren[_currentIndex - 1];
    final SemanticsNode nextChild = indexedChildren[_currentIndex + 1];
    if (nextChild != null) {
      config.increasedValue = nextChild.label;
      config.onIncrease = _handleIncrease;
    }
    if (previousChild != null) {
      config.decreasedValue = previousChild.label;
      config.onDecrease = _handleDecrease;
    }
    node.updateWith(config: config);
  }
}
