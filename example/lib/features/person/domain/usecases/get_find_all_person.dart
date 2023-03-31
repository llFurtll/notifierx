import '../../../../core/dic/pt.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/person.dart';
import '../repositories/person_repository.dart';

class GetFindAllPerson extends UseCase<List<Person>, NoParams> {
  final PersonRepository repository;

  GetFindAllPerson(this.repository);

  @override
  Future<Result<Failure, List<Person>>> call(NoParams params) async {
    final result = await repository.findAll();

    return result.fold((left) {
      final message = pt[left.message];
      return Left(UseCaseFailure(message: message!));
    }, (right) => Right(right));
  }
} 