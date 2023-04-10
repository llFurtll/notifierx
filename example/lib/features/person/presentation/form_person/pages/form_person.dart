import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_obs_screen.dart';

import '../notifiers/form_person_notifier.dart';

class FormPerson extends NotifierXObsScreen<FormPersonNotifier> {
  const FormPerson({super.key});

  @override
  Widget builder(BuildContext context) {
    return AlertDialog(
      title: Text(notifier.isEdit ? "Editar pessoa" : "Cadastrar nova pessoa"),
      actions: _buildActions(context),
      content: _buildContent(),
    );
  }

  @override
  Widget loading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Fechar")
      ),
      TextButton(
        onPressed: notifier.save,
        child: Text(notifier.isEdit ? "Atualizar" : "Cadastrar")
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
                initialValue: notifier.formPerson.nome,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Nome"
                ),
                validator: notifier.validator,
                onSaved: (value) => notifier.onSave(value, "nome"),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                initialValue: notifier.formPerson.sobrenome,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Sobrenome"
                ),
                validator: notifier.validator,
                onSaved: (value) => notifier.onSave(value, "sobrenome"),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                initialValue: notifier.formPerson.dataNascimento,
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