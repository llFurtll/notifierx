import 'package:flutter/widgets.dart';

import 'notifierx_context.dart';
import 'notifierx_listener.dart';

/// InheritedWidget responsável em possuíor as dependências globais e
/// todos nos NotiferXListener da aplicação, para ser possível posteriomente
/// ser recuperado.
/// 
/// globalDependencies: Seria todas as dependências globais da aplicação, exemplo:
/// Caso você tenha alguma dependência onde todos os repository do seu sistema
/// necessita ter, nisso adicione nas dependências globais onde posteriomente
/// você irá utilizar para injeção de dependência.
/// 
/// depencencies: Aqui ficará todos os NotifierXListener da aplicação, nesse caso
/// é uma lista de função, onde para cada tela que você tenha um NotifierXListener
/// deverá criar uma função onde retorna a instância do mesmo, nessa função
/// você terá acesso as dependências globais da aplicação, caso precise de uma
/// que injete em seu Notifier.
class NotifierXDependencies extends InheritedWidget {
  final List<NotifierXListener Function(List<dynamic> global)> depencencies;
  final List<dynamic> globalDependencies;

  static final _dependencies = <NotifierXListener>[];

  NotifierXDependencies({
    super.key,
    this.globalDependencies = const [],
    required this.depencencies,
    required Widget child,
  }) :
  super(child: Builder(builder: (context) {
    NotifierXContext.context ??= context;

    return child;
  })
    ) {
    for (var function in depencencies) {
      _dependencies.add(function(globalDependencies));
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static I of<I extends NotifierXListener>(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<NotifierXDependencies>();
    assert(inherited != null, "Unconfigured injections");
    
    try {
      return _dependencies.whereType<I>().first;
    } catch (_) {
      throw("Unconfigured dependency: ${I.runtimeType}");
    }
  }
}