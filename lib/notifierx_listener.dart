import 'package:flutter/widgets.dart';

import 'notifierx_mediator.dart';
import 'notifierx_state.dart';

abstract class NotifierXListener extends ChangeNotifier {
  final mediator = NotifierXMediator();

  NotifierXState state = NotifierXState.ready;
  late BuildContext context;
  
  @mustCallSuper
  void onInit() {
    mediator.register(this);
  }

  @mustCallSuper
  void onClose() {
    mediator.unregister(this);
  }

  void onDependencies() {}

  void setLoading() {
    state = NotifierXState.loading;
    notifyListeners();
  }

  void setReady() {
    state = NotifierXState.ready;
    notifyListeners();
  }

  void setError() {
    state = NotifierXState.error;
    notifyListeners();
  }

  void receive(String message) {}
}
