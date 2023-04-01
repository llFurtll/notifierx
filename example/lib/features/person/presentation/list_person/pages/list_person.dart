import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_obs.dart';

import '../../form_person/pages/form_person.dart';
import '../notifiers/list_person_notifier.dart';

class ListPerson extends StatelessWidget {
  const ListPerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFab(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Listagem de pessoas"),
    );
  }

  NotifierXObs _buildBody(BuildContext context) {
    return NotifierXObs<ListPersonNotifier>(
      context: context,
      build: (context, notifier) {
        if (notifier.peoples.isEmpty) {
          return const Center(
            child: Text(
              "Nenhuma pessoa cadastrada!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            )
          );
        }
        
        return ListView(
          children: notifier.peoples.map((e) => Container()).toList(),
        );
      },
      loading: (context, notifier) =>
        const Center(child: CircularProgressIndicator()),
      error: (context, notifier) {
        return Center(
          child: Text(
            notifier.messageError,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.red
            ),
          )
        );
      },
    );
  }

  FloatingActionButton _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog(context: context, builder: (innerContext) => const FormPerson()),
      child: const Icon(Icons.add),
    );
  }
}