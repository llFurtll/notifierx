import '../../domain/entities/person.dart';

class PersonModel extends Person {
  const PersonModel({
    required super.id,
    required super.nome,
    required super.sobrenome,
    required super.dataNascimento
  });
}