import 'package:flutter/widgets.dart';
import 'package:notifierx/notifierx_obs.dart';

import 'notifierx_context.dart';
import 'notifierx_dependencies.dart';
import 'notifierx_listener.dart';

/// Essa classe serve para criar um Widget encapsular todos os Widgets e realizar
/// alterações de estado quando necessário, exemplo: FloatActionButton, AppBar
/// entre outros.
abstract class NotifierXObsScreen<T extends NotifierXListener> extends StatelessWidget {
  const NotifierXObsScreen({
    super.key
  });

  T get notifier => NotifierXDependencies.of<T>(NotifierXContext.context!);

  @override
  Widget build(BuildContext context) {
    return NotifierXObs<T>(
      build: (context, notifier) => builder(context),
      error: (context, notifier) => error(context),
      loading: (context, notifier) => loading(context),
    );
  }

  Widget loading(BuildContext context) {
    return builder(context);
  }
  
  Widget error(BuildContext context) {
    return builder(context);
  }

  Widget builder(BuildContext context);
}