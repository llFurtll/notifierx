import 'package:flutter/widgets.dart';

import 'notifierx_mediator.dart';
import 'notifierx_state.dart';

/// Classe que você deverá erdar ao criar um Notifier para seu Widget,
/// por esse meio é possível realizar as alterações de estado para
/// loading/ready/error, também conterá todas as regras de negócio
/// do seu Widget. Aqui também é possível configurar as chamadas
/// que seu Notifier irá receber e quais ações tomar após determinada
/// chamada.
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
