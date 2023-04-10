import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../entities/person.dart';

abstract class PersonRepository {
  Future<Result<Failure, List<Person>>> findAll();
  Future<Result<Failure, Person>> insert(Person person);
  Future<Result<Failure, Person>> update(Person person);
  Future<Result<Failure, void>> delete(int id);
  Future<Result<Failure, Person>> findById({required int id});
}