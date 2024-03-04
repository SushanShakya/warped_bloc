// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Debouncer {
  int? lastExecutedTimestamp;
  int waitTime;
  Debouncer({
    required this.waitTime,
  });

  void debounce(VoidCallback fn) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (lastExecutedTimestamp == null) {
      fn();
      lastExecutedTimestamp = now;
      return;
    }
    var diff = now - lastExecutedTimestamp!;
    if (diff < waitTime) return;
    fn();
    lastExecutedTimestamp = now;
  }
}

class PaginatedBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    ScrollController controller,
  ) builder;

  final VoidCallback onFetchMore;
  final int debouncerWaitDuration;

  const PaginatedBuilder({
    Key? key,
    required this.builder,
    required this.onFetchMore,
    this.debouncerWaitDuration = 3000,
  }) : super(key: key);

  @override
  State<PaginatedBuilder> createState() => _PaginatedBuilderState();
}

class _PaginatedBuilderState extends State<PaginatedBuilder> {
  late ScrollController controller;
  late Debouncer debouncer;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    debouncer = Debouncer(waitTime: widget.debouncerWaitDuration);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (controller.position.extentAfter == 0) {
        debouncer.debounce(() {
          widget.onFetchMore();
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: widget.builder(context, controller),
    );
  }
}
