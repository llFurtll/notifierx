import 'package:flutter/widgets.dart';

import 'notifierx_context.dart';
import 'notifierx_dependencies.dart';
import 'notifierx_listener.dart';

abstract class NotifierXObsScreen<T extends NotifierXListener> extends StatelessWidget {
  const NotifierXObsScreen({
    super.key
  });

  T get notifier => NotifierXDependencies.of<T>(NotifierXContext.context!);

  @override
  Widget build(BuildContext context);
}