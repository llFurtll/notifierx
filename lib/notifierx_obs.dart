import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_listener.dart';

import 'notifierx_state.dart';

class NotifierXObs<T extends NotifierXListener> extends StatefulWidget {
  final T notifier;
  final Widget Function(BuildContext context, T notifier) loading;
  final Widget Function(BuildContext context, T notifier) error;
  final Widget Function(BuildContext context, T notifier) build;

  const NotifierXObs(
    {
      required this.notifier,
      required this.build,
      required this.loading,
      required this.error,
      super.key
    }
  );

  @override
  State<StatefulWidget> createState() => _NotifierXObsState<T>();
}

class _NotifierXObsState<T extends NotifierXListener> extends State<NotifierXObs<T>> {
  late T notifier;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_handleChange);
    widget.notifier.onInit();
    notifier = widget.notifier;
  }

  @override
  void dispose() {
    widget.notifier.onClose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.notifier.onDependencies();
  }

  @override
  void didUpdateWidget(NotifierXObs<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.notifier != oldWidget.notifier) {
      oldWidget.notifier.removeListener(_handleChange);
      widget.notifier.addListener(_handleChange);
    }
  }

  void _handleChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (notifier.state) {
      case NotifierXState.loading:
        return widget.loading(context, notifier);
      case NotifierXState.error:
        return widget.error(context, notifier);
      default:
        return widget.build(context, notifier);
    }
  }
}
