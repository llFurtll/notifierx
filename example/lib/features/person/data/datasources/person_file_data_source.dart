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

    var json = jsonDecode(db.readAsStringSync()) as Map<int, PersonModel>;
    json.remove(id);
  }

  @override
  Future<List<PersonModel>> findAll() async {
    final db = await dataSource.getDataSource();
    if (db == null) throw FileException("");

    final List<PersonModel> result = [];
    final data = db.readAsStringSync();
    if (Util.isNullOrEmpty(data)) {
      return result;
    }

    var json = jsonDecode(db.readAsStringSync()) as Map<int, PersonModel>;
    json.forEach((key, value) {
      result.add(value);
    });

    return result;
  }

  @override
  Future<PersonModel> findById({required int id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<PersonModel> insert({required PersonModel person}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<PersonModel> update({required PersonModel person}) {
    // TODO: implement update
    throw UnimplementedError();
  }

}