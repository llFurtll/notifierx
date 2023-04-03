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
}