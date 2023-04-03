import '../../../../core/dic/pt.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/person.dart';
import '../repositories/person_repository.dart';

class GetSavePerson extends UseCase<Person, SavePersonParams> {
  final PersonRepository repository;

  GetSavePerson(this.repository);

  @override
  Future<Result<Failure, Person>> call(SavePersonParams params) async {
    final result = await repository.insert(params.person);
    
    return result.fold(
      (left) => Left(UseCaseFailure(message: pt[left.message]!)),
      (right) => Right(right));
  }

}

class SavePersonParams extends Params {
  final Person person;

  SavePersonParams({
    required this.person
  });
}