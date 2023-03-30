import 'package:flutter/widgets.dart';

import 'notifierx_listener.dart';

class NotifierXDependencies<T extends NotifierXListener> extends InheritedWidget {
  final List<T Function()> created;

  static final dependencies = <NotifierXListener>[];

  NotifierXDependencies({
    super.key,
    required this.created,
    required super.child
  }) {
    for (var function in created) {
      dependencies.add(function());
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static I of<I extends NotifierXListener>(BuildContext context, Type type) {
    final inherited = context.dependOnInheritedWidgetOfExactType<NotifierXDependencies>();
    assert(inherited != null, "Injections not configured");
    
    return dependencies.firstWhere((element) => element.runtimeType == type) as I;
  }
}