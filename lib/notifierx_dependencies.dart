import 'package:flutter/widgets.dart';

import 'notifierx_listener.dart';

class NotifierXDependencies extends InheritedWidget {
  final List<NotifierXListener Function(List<dynamic> global)> created;
  final List<dynamic> global;

  static final dependencies = <NotifierXListener>[];

  NotifierXDependencies({
    super.key,
    this.global = const [],
    required this.created,
    required super.child
  }) {
    for (var function in created) {
      dependencies.add(function(global));
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static I of<I extends NotifierXListener>(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<NotifierXDependencies>();
    assert(inherited != null, "Unconfigured injections");
    
    return dependencies.whereType<I>().first;
  }
}