import 'dart:io';

import 'package:notifierx/notifierx_listener.dart';

import '../../../../../core/datasource/data_source.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/datasources/person_file_data_source.dart';
import '../../../data/repositories/person_repository_impl.dart';
import '../../../domain/usecases/get_delete_person.dart';
import '../../../domain/usecases/get_find_all_person.dart';

class ListPersonNotifier extends NotifierXListener {
  final GetFindAllPerson getFindAllPerson;
  final GetDeletePerson getDeletePerson;
  
  ListPersonNotifier({
    required this.getFindAllPerson,
    required this.getDeletePerson
  });

  // VARIAVEIS FINAL
  final peoples = [];

  // ERROS
  String messageError = "";

  @override
  void onInit() {
    super.onInit();
    _loadPeoples();
  }

  void _loadPeoples() {
    Future.value()
      .then((_) => setLoading())
      .then((_) => getFindAllPerson(NoParams()))
      .then((value) => value.fold((left) => throw left, (right) => right))
      .then((value) {
        peoples.clear();
        peoples.addAll(value);
        setReady();
      })
      .catchError((error) {
        messageError = error.message;
        setError();
      });
  }

  void _deletePeople(int id) {
    Future.value()
      .then((_) => setLoading())
      .then((_) => getDeletePerson(DeletePersonParams(id: id)))
      .then((value) => value.fold((left) => throw left, (right) => right))
      .then((_) => _loadPeoples())
      .catchError((error) {});
  }
  
  @override
  void receive(String message, dynamic value) {
    switch (message) {
      case "load":
        _loadPeoples();
        break;
      case "delete":
        _deletePeople(value);
        break;
    }
  }
}

ListPersonNotifier createListPersonNotifier(List<dynamic> global) {
  final dataSource = PersonFileDataSourceImpl(
    dataSource: global.whereType<DataSource<File>>().first
  );
  final repository = PersonRepositoryImpl(dataSource);

  final getFindAllPerson = GetFindAllPerson(repository);
  final getDeletePerson = GetDeletePerson(repository);

  final notifier = ListPersonNotifier(
    getFindAllPerson: getFindAllPerson,
    getDeletePerson: getDeletePerson
  );

  return notifier;
}