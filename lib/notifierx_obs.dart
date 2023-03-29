import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_listener.dart';

class NotifierXObs<T extends NotifierXListener> extends StatefulWidget {
  final T notifier;
  final Widget Function(BuildContext context, T value) builder;

  const NotifierXObs({required this.builder, required this.notifier, super.key});

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
  Widget build(BuildContext context) => widget.builder(context, notifier);
}
