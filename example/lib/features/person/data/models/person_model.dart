import '../../domain/entities/person.dart';

class PersonModel extends Person {
  PersonModel({
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
      dataNascimento: data["dataNascimento"]
    );
  }

  factory PersonModel.fromEntity(Person person) {
    return PersonModel(
      id: person.id,
      nome: person.nome,
      sobrenome: person.sobrenome,
      dataNascimento: person.dataNascimento
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "nome": nome,
      "sobrenome": sobrenome,
      "dataNascimento": dataNascimento ?? DateTime.now().toIso8601String()
    };

    return data; 
  }
}