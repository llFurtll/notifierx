import 'package:flutter/widgets.dart';
import 'package:notifierx/notifierx_state.dart';

abstract class NotifierXListener extends ChangeNotifier {
  NotifierXState state;

  NotifierXListener({this.state = NotifierXState.ready});

  void onInit();
  void onClose();
  void onDependencies();

  setLoading() {
    state = NotifierXState.loading;
    notifyListeners();
  }

  setReady() {
    state = NotifierXState.ready;
    notifyListeners();
  }

  setError() {
    state = NotifierXState.error;
    notifyListeners();
  }
}
