import 'package:flutter/widgets.dart';

class InfinityScroll extends StatelessWidget {
  final VoidCallback onLoadMore;
  final bool condition;
  final double distance;
  final Widget child;

  const InfinityScroll({
    Key key,
    @required this.onLoadMore,
    @required this.child,
    this.condition,
    this.distance: 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: condition != null && condition
          ? (_) {
        if (_.metrics.pixels >= (_.metrics.maxScrollExtent - distance)) {
          if (onLoadMore != null) onLoadMore();
        }
        return;
      }
          : null,
      child: child,
    );
  }
}
