import '../../../../core/dic/pt.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/person_repository.dart';

class GetDeletePerson extends UseCase<void, DeletePersonParams> {
  final PersonRepository repository;

  GetDeletePerson(this.repository);

  @override
  Future<Result<Failure, void>> call(DeletePersonParams params) async {
    final result = await repository.delete(params.id);
    
    return result.fold(
      (left) => Left(UseCaseFailure(message: pt[left.message]!)),
      (right) => Right(right));
  }

}

class DeletePersonParams extends Params {
  final int id;

  DeletePersonParams({
    required this.id
  });
}