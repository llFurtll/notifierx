import '../../domain/entities/person.dart';

class PersonModel extends Person {
  const PersonModel({
    required super.id,
    required super.nome,
    required super.sobrenome,
    required super.dataNascimento
  });

  factory PersonModel.fromMap(Map<String, dynamic> data) {
    return PersonModel(
      id: data["id"],
      nome: data["nome"],
      sobrenome: data["sobrenome"],
      dataNascimento: DateTime.parse(data["dataNascimento"])
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
      "dataNascimento":
        dataNascimento?.toIso8601String() ?? DateTime.now().toIso8601String()
    };

    return data; 
  }
}