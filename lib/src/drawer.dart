import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExtDrawer extends StatefulWidget {
  final Widget accountName;
  final Widget accountEmail;
  final Widget accountPicture;
  final Decoration headerDecoration;
  final Color arrowColor;
  final List<Widget> children;
  final List<Widget> backChildren;

  const ExtDrawer({
    Key key,
    this.accountName,
    this.accountEmail,
    this.accountPicture,
    this.headerDecoration,
    this.arrowColor,
    this.children: const [],
    this.backChildren: const [],
  }) : super(key: key);

  @override
  _ExtDrawerState createState() => _ExtDrawerState();
}

class _ExtDrawerState extends State<ExtDrawer> with TickerProviderStateMixin {
  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasAccountHeader = widget.accountName != null ||
        widget.accountEmail != null ||
        widget.accountPicture != null;

    return Drawer(
      child: Column(
        children: [
          if (hasAccountHeader)
            UserAccountsDrawerHeader(
              accountName: widget.accountName,
              accountEmail: widget.accountEmail,
              currentAccountPicture: widget.accountPicture,
              arrowColor: widget.arrowColor,
              decoration: widget.headerDecoration,
              margin: EdgeInsets.zero,
              onDetailsPressed: widget.backChildren.isEmpty
                  ? null
                  : () {
                      _showDrawerContents = !_showDrawerContents;
                      if (_showDrawerContents)
                        _controller.reverse();
                      else
                        _controller.forward();
                    },
            ),
          Expanded(
            child: SafeArea(
              top: !hasAccountHeader,
              child: ListView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.children,
                        ),
                      ),
                      // The drawer's "details" view.
                      SlideTransition(
                        position: _drawerDetailsPosition,
                        child: FadeTransition(
                          opacity: ReverseAnimation(_drawerContentsOpacity),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: widget.backChildren,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
