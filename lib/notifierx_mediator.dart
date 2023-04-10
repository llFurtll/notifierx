import 'notifierx_listener.dart';

/// Um mediator para ser possível disparar chamadas para determinado
/// Notifier, assim é possível em determinados locais da aplicação disparar
/// mensagem de evento para um determinado Notifier e nisso realizar alguma
/// alteração de estado por exemplo.
class NotifierXMediator {
  NotifierXMediator._privateConstructor();

  static final NotifierXMediator _instance = NotifierXMediator._privateConstructor();

  factory NotifierXMediator() {
    return _instance;
  }

  final _listeners = <NotifierXListener>[];

  void register(NotifierXListener listener) {
    _listeners.add(listener);
  }

  void unregister(NotifierXListener listener) {
    _listeners.remove(listener);
  }

  void send<T extends NotifierXListener>(String message, { dynamic value }) {
    final filteredListener = _listeners.whereType<T>();

    if (filteredListener.isEmpty) return;

    final listener = filteredListener.first;
    listener.receive(message, value);
  }
}