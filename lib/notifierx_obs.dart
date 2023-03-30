import 'package:flutter/material.dart';

import 'notifierx_dependencies.dart';
import 'notifierx_listener.dart';
import 'notifierx_state.dart';

class NotifierXObs<T extends NotifierXListener> extends StatefulWidget {
  final BuildContext context;
  final Widget Function(BuildContext context, T notifier) loading;
  final Widget Function(BuildContext context, T notifier) error;
  final Widget Function(BuildContext context, T notifier) build;

  const NotifierXObs({
    required this.context,
    required this.build,
    required this.loading,
    required this.error,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _NotifierXObsState<T>();
}

class _NotifierXObsState<T extends NotifierXListener> extends State<NotifierXObs<T>> {
  late T notifier;

  @override
  void initState() {
    super.initState();
    notifier = NotifierXDependencies.of<T>(widget.context, T.runtimeType);
    notifier.addListener(_handleChange);
    notifier.onInit();
  }

  @override
  void dispose() {
    notifier.onClose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifier.onDependencies();
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
