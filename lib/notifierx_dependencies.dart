import 'package:flutter/widgets.dart';

import 'notifierx_context.dart';
import 'notifierx_listener.dart';

class NotifierXDependencies extends InheritedWidget {
  final List<NotifierXListener Function(List<dynamic> global)> depencencies;
  final List<dynamic> globalDependencies;

  static final _dependencies = <NotifierXListener>[];

  NotifierXDependencies({
    super.key,
    this.globalDependencies = const [],
    required this.depencencies,
    required Widget child,
  }) :
  super(child: Builder(builder: (context) {
    NotifierXContext.context ??= context;

    return child;
  })
    ) {
    for (var function in depencencies) {
      _dependencies.add(function(globalDependencies));
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static I of<I extends NotifierXListener>(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<NotifierXDependencies>();
    assert(inherited != null, "Unconfigured injections");
    
    try {
      return _dependencies.whereType<I>().first;
    } catch (_) {
      throw("Unconfigured dependency: ${I.runtimeType}");
    }
  }
}