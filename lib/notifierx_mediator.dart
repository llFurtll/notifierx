import 'notifierx_listener.dart';

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

  void send<T extends NotifierXListener>(String message) {
    final filteredListener = _listeners.whereType<T>();

    if (filteredListener.isEmpty) return;

    final listener = filteredListener.first;
    listener.receive(message);
  }
}