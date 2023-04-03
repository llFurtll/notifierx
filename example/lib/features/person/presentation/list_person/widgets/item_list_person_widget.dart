import 'package:flutter/material.dart';

import '../../../domain/entities/person.dart';

class ItemListPersonWidget extends StatelessWidget {
  final Person person;

  const ItemListPersonWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5.0,
            blurRadius: 7.0,
            offset: const Offset(0.0, 0.0),
          )
        ]
      ),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${person.nome ?? 'Sem nome'} "
            "${person.sobrenome ?? 'Sem sobrenome'}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            person.dataNascimento?.toIso8601String() ?? "Sem data de nascimento",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 15.0
            ),
          ),
        ],
      ),
    );
  }
}