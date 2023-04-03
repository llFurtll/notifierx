import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_listener.dart';

class FormPersonNotifier extends NotifierXListener {
  final formKey = GlobalKey<FormState>();
}

FormPersonNotifier createFormPersonNotifier(List<dynamic> global) {
  return FormPersonNotifier();
}