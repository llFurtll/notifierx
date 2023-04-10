import '../../../../core/result/result.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../datasources/person_file_data_source.dart';
import '../models/person_model.dart';
import '../../domain/entities/person.dart';
import '../../domain/repositories/person_repository.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonFileDataSource dataSource;

  PersonRepositoryImpl(this.dataSource);

  @override
  Future<Result<Failure, List<Person>>> findAll() async {
    try {
      final result = await dataSource.findAll();
      return Right(result);
    } on FileException catch (_) {
      return Left(FileFailure(message: "erro-busca-person"));
    }
  }

  @override
  Future<Result<Failure, Person>> insert(Person person) async {
    try {
      final result = await dataSource.insert(person: PersonModel.fromEntity(person));
      return Right(result);
    } on FileException catch (_) {
      return Left(FileFailure(message: "erro-insert-person"));
    }
  }

  @override
  Future<Result<Failure, Person>> update(Person person) async {
    try {
      final result = await dataSource.update(person: PersonModel.fromEntity(person));
      return Right(result);
    } on FileException catch (_) {
      return Left(FileFailure(message: "erro-update-person"));
    }
  }

  @override
  Future<Result<Failure, void>> delete(int id) async {
    try {
      final result = await dataSource.delete(id: id);
      return Right(result);
    } on FileException catch (_) {
      return Left(FileFailure(message: "erro-delete-person"));
    }
  }

  @override
  Future<Result<Failure, Person>> findById({required int id}) async {
    try {
      final result = await dataSource.findById(id: id);
      return Right(result);
    } on FileException catch (_) {
      return Left(FileFailure(message: "erro-find-person"));
    }
  }
}