abstract class Failure {
  final String message;

  const Failure({
    required this.message
  });
}

class FileFailure extends Failure {
  FileFailure({required super.message});
}

class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message});
}