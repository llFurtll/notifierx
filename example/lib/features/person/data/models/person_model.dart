import '../../domain/entities/person.dart';

class PersonModel extends Person {
  const PersonModel({
    required super.id,
    required super.nome,
    required super.sobrenome,
    required super.dataNascimento
  });

  factory PersonModel.fromMap(Map data) {
    return PersonModel(
      id: data["id"],
      nome: data["nome"],
      sobrenome: data["sobrenome"],
      dataNascimento: DateTime.parse(data["dataNascimento"])
    );
  }

  Map<int, PersonModel> toJson() {
    final Map<int, PersonModel> data = {};
    data[id!] = this;

    return data; 
  }
}