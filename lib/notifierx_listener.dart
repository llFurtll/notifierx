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
    if (state != NotifierXState.loading) {
      state = NotifierXState.loading;
      notifyListeners();
    }
  }

  void setReady() {
    if (state != NotifierXState.ready) {
      state = NotifierXState.ready;
      notifyListeners();
    }
  }

  void setError() {
    if (state != NotifierXState.error) {
      state = NotifierXState.error;
      notifyListeners();
    }
  }

  void receive(String message, dynamic value) {}
}
