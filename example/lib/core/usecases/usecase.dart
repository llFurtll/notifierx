import '../failures/failures.dart';
import '../result/result.dart';

abstract class UseCase<R, P extends Params> {
  Future<Result<Failure, R>> call(P params);
}

abstract class Params {}

class NoParams extends Params {}