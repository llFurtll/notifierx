import 'dart:io';

import 'package:notifierx/notifierx_listener.dart';

import '../../../../../core/datasource/data_source.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/datasources/person_file_data_source.dart';
import '../../../data/repositories/person_repository_impl.dart';
import '../../../domain/usecases/get_find_all_person.dart';

class ListPersonNotifier extends NotifierXListener {
  final GetFindAllPerson getFindAllPerson;

  ListPersonNotifier({
    required this.getFindAllPerson
  });

  // VARIAVEIS FINAL
  final peoples = [];

  // ERROS
  String messageError = "";

  @override
  void onInit() {
    super.onInit();

    Future.value()
      .then((_) => setLoading())
      .then((_) => getFindAllPerson(NoParams()))
      .then((value) => value.fold((left) => throw left, (right) => right))
      .then((value) {
        peoples.addAll(value);
        setReady();
      })
      .catchError((error) {
        messageError = error.message;
        setError();
      });
  }
}

ListPersonNotifier createListPersonNotifier(List<dynamic> global) {
  final dataSource = PersonFileDataSourceImpl(global.whereType<DataSource<File>>().first);
  final repository = PersonRepositoryImpl(dataSource);
  final getFindAllPerson = GetFindAllPerson(repository);

  final notifier = ListPersonNotifier(getFindAllPerson: getFindAllPerson);

  return notifier;
}