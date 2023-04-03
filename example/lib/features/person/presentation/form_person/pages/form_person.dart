import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_obs_screen.dart';

import '../notifiers/form_person_notifier.dart';

class FormPerson extends NotifierXObsScreen<FormPersonNotifier> {
  const FormPerson({super.key});

  @override
  Widget builder(BuildContext context) {
    return AlertDialog(
      title: const Text("Cadastrar nova pessoa"),
      actions: _buildActions(context),
      content: _buildContent(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Fechar")
      ),
      TextButton(
        onPressed: notifier.save,
        child: const Text("Cadastrar")
      )
    ];
  }

  Widget _buildContent() {
    return Theme(
      data: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
          )
        )
      ),
      child: SingleChildScrollView(
        child: Form(
          key: notifier.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Nome"
                ),
                validator: notifier.validator,
                onSaved: (value) => notifier.onSave(value, "nome"),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Sobrenome"
                ),
                validator: notifier.validator,
                onSaved: (value) => notifier.onSave(value, "sobrenome"),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  hintText: "Data de nascimento"
                ),
                validator: notifier.validator,
                onSaved: (value) => notifier.onSave(value, "date"),
              ),
            ],
          )
        ),
      )
    );
  }
}