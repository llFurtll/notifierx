import 'dart:convert';
import 'dart:io';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/datasource/data_source.dart';
import '../../../../core/utils/util.dart';
import '../models/person_model.dart';

abstract class PersonFileDataSource {
  Future<List<PersonModel>> findAll();
  Future<PersonModel> findById({required int id});
  Future<PersonModel> insert({required PersonModel person});
  Future<PersonModel> update({required PersonModel person});
  Future<void> delete({required int id});
}

class PersonFileDataSourceImpl extends PersonFileDataSource {
  final DataSource<File> dataSource;

  PersonFileDataSourceImpl(this.dataSource);

  @override
  Future<void> delete({required int id}) async {
    final db = await dataSource.getDataSource();
    if (db == null) throw FileException("");

    try {
      var json = jsonDecode(db.readAsStringSync()) as List<dynamic>;
      json.removeWhere((element) => element["id"] == id);
      db.writeAsString(jsonEncode(json));
    } catch (_) {
      throw FileException("");
    }
  }

  @override
  Future<List<PersonModel>> findAll() async {
    final db = await dataSource.getDataSource();
    if (db == null) throw FileException("");

    try {
      final List<PersonModel> result = [];
      final data = db.readAsStringSync();
      if (Util.isNullOrEmpty(data)) {
        return result;
      }

      var json = jsonDecode(db.readAsStringSync()) as List<dynamic>;
      for (Map item in json) {
        result.add(PersonModel.fromMap(item));
      }

      return result;
    } catch (_) {
      throw FileException("");
    }
  }

  @override
  Future<PersonModel> findById({required int id}) async {
    final db = await dataSource.getDataSource();
    if (db == null) throw FileException("");

    try {
      var json = jsonDecode(db.readAsStringSync()) as List<dynamic>;
      final index = json.indexWhere((element) => element["id"] == id);
      return json[index];
    } catch (_) {
      throw FileException("");
    }
  }

  @override
  Future<PersonModel> insert({required PersonModel person}) async {
    final db = await dataSource.getDataSource();
    if (db == null) throw FileException("");

    try {
      final data = db.readAsStringSync();
      late final List<dynamic> fileJson;
      if (Util.isNullOrEmpty(data)) {
        fileJson = [];
      } else {
        fileJson = jsonDecode(data) as List<dynamic>;
      }
      fileJson.add(person.toJson());
      db.writeAsStringSync(jsonEncode(fileJson));
      
      return person;
    } catch (_) {
      throw FileException("");
    }
  }

  @override
  Future<PersonModel> update({required PersonModel person}) {
    // TODO: implement update
    throw UnimplementedError();
  }

}