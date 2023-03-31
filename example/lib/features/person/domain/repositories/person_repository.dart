import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../entities/person.dart';

abstract class PersonRepository {
  Future<Result<Failure, List<Person>>> findAll();
}