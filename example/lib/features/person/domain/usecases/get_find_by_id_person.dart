import '../../../../core/dic/pt.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/person.dart';
import '../repositories/person_repository.dart';

class GetFindByIdPerson extends UseCase<Person, FindByIdPersonParams> {
  final PersonRepository repository;

  GetFindByIdPerson(this.repository);

  @override
  Future<Result<Failure, Person>> call(FindByIdPersonParams params) async {
    final result = await repository.findById(id: params.id);
    
    return result.fold(
      (left) => Left(UseCaseFailure(message: pt[left.message]!)),
      (right) => Right(right));
  }
}

class FindByIdPersonParams extends Params {
  final int id;

  FindByIdPersonParams({
    required this.id
  });
}