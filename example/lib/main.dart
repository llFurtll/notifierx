import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_dependencies.dart';

import 'features/person/presentation/list_person/pages/list_person.dart';
import 'features/person/presentation/list_person/notifiers/list_person_notifier.dart';

void main() => runApp(
  NotifierXDependencies(
    created: const [
      createListPersonNotifier
    ],
    child: const MaterialApp(
      home: ListPerson(),
    )
  )
);