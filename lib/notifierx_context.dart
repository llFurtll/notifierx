import 'package:flutter/material.dart';


/// Esse contexto é criado no início do aplicativo,
/// ele armazena como um contexto global, para ser possível
/// obter as dependências do NotifierXDependencies posteriomente.
class NotifierXContext {
  static BuildContext? context;
}