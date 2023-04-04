import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_listener.dart';

import '../../../../../core/datasource/data_source.dart';
import '../../../../../core/utils/util.dart';
import '../../../data/datasources/person_file_data_source.dart';
import '../../../data/repositories/person_repository_impl.dart';
import '../../../domain/entities/person.dart';
import '../../../domain/usecases/get_save_person.dart';
import '../../list_person/notifiers/list_person_notifier.dart';

class FormPersonNotifier extends NotifierXListener {
  final GetSavePerson getSavePerson;

  FormPersonNotifier({
    required this.getSavePerson
  });

  final formKey = GlobalKey<FormState>();
  final formPerson = FormPerson();

  void save() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      formPerson.id = UniqueKey().hashCode;

      Future.value()
        .then((_) => getSavePerson(
          SavePersonParams(
            person: formPerson.toPerson()
          )
        ))
        .then((_) => mediator.send<ListPersonNotifier>("load"))
        .then((_) => Navigator.of(context).pop())
        .catchError((error) => {
          
        });
    }
  }

  void onSave(String? value, String campo) {
    switch (campo) {
      case "nome":
        formPerson.nome = value;
        break;
      case "sobrenome":
        formPerson.sobrenome = value;
        break;
      case "data":
        formPerson.dataNascimento = DateTime.parse(value!);
        break;
    }
  }

  String? validator(String? value) {
    if (Util.isNullOrEmpty(value)) {
      return "Campo obrigatório";
    }

    return null;
  }
}

class FormPerson {
  int? id;
  String? nome;
  String? sobrenome;
  DateTime? dataNascimento;

  FormPerson({
    this.id,
    this.nome,
    this.sobrenome,
    this.dataNascimento
  });
  
  Person toPerson() {
    return Person(
      id: id,
      nome: nome,
      sobrenome: sobrenome,
      dataNascimento: dataNascimento
    );
  }
}

FormPersonNotifier createFormPersonNotifier(List<dynamic> global) {
  final dataSource = PersonFileDataSourceImpl(global.whereType<DataSource<File>>().first);
  final repository = PersonRepositoryImpl(dataSource);
  final getSavePerson = GetSavePerson(repository);

  final notifier = FormPersonNotifier(getSavePerson: getSavePerson);

  return notifier;
}