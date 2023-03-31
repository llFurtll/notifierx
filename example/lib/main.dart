import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_dependencies.dart';
import 'package:notifierx/notifierx_listener.dart';
import 'package:notifierx/notifierx_mediator.dart';
import 'package:notifierx/notifierx_obs.dart';

void main() {
  runApp(
    NotifierXDependencies(
      created: [
        () => MyAppNotifier("Olá, seja bem vindo!"),
        () => FabNotifier()
      ],
      child: const MaterialApp(
        home: MyApp(),
      )
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotifierXObs<MyAppNotifier>(
        context: context,
        build: (context, notifier) {
          return Center(child: Text(notifier.message));
        },
        loading: (context, notifier) {
          return const Center(child: CircularProgressIndicator());
        },
        error: (context, notifier) {
          return const Text("Deu erro...");
        }
      ),
      floatingActionButton: NotifierXObs<FabNotifier>(
        context: context,
        build: (context, notifier) {
          return FloatingActionButton(
            onPressed: notifier.isDisable ? null : () {
              final mediator = NotifierXMediator();
              mediator.send<MyAppNotifier>("carregar");
            },
            child: const Icon(Icons.add),
          );
        },
      )
    );
  }
}

class MyAppNotifier extends NotifierXListener {
  final String message;

  MyAppNotifier(this.message);

  @override
  void onInit() {
    super.onInit();

    carregar();
  }

  @override
  void receive(String message) {
    switch (message) {
      case "carregar":
        carregar();
        break;
    }
  }

  void carregar() {
    mediator.send<FabNotifier>("disable");
    Future.value()
      .then((_) => setLoading())
      .then((_) => Future.delayed(const Duration(seconds: 2)))
      .then((_) => setReady())
      .then((_) => mediator.send<FabNotifier>(""));
  }
}

class FabNotifier extends NotifierXListener {
  bool isDisable = true;

  @override
  void receive(String message) {
    switch (message) {
      case "disable":
        isDisable = true;
        notifyListeners();
        break;
      default:
        isDisable = false;
        notifyListeners();
        break;
    }
  }
}