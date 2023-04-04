import 'package:flutter/material.dart';

import 'notifierx_context.dart';
import 'notifierx_dependencies.dart';
import 'notifierx_listener.dart';
import 'notifierx_state.dart';

class NotifierXObs<T extends NotifierXListener> extends StatefulWidget {
  final Widget Function(BuildContext context, T notifier)? loading;
  final Widget Function(BuildContext context, T notifier)? error;
  final Widget Function(BuildContext context, T notifier) build;

  const NotifierXObs({
    required this.build,
    this.loading,
    this.error,
    super.key
  });

  T get notifier => NotifierXDependencies.of<T>(NotifierXContext.context!);

  @override
  State<StatefulWidget> createState() => _NotifierXObsState<T>();
}

class _NotifierXObsState<T extends NotifierXListener> extends State<NotifierXObs<T>> {
  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_handleChange);
    widget.notifier.onInit();
  }
  
  @override
  void dispose() {
    widget.notifier.onClose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.notifier.context = context;
    widget.notifier.onDependencies();
  }

  void _handleChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.notifier.state) {
      case NotifierXState.loading:
        if (widget.loading == null) {
          return widget.build(context, widget.notifier);
        }

        return widget.loading!(context, widget.notifier);
      case NotifierXState.error:
        if (widget.error == null) {
          return widget.build(context, widget.notifier);
        }

        return widget.error!(context, widget.notifier);
      default:
        return widget.build(context, widget.notifier);
    }
  }
}
