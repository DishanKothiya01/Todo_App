import 'package:flutter/material.dart';

class PullToRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? indicatorColor;

  const PullToRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    required this.indicatorColor
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: indicatorColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
