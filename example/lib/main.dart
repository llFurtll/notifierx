import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_dependencies.dart';
import 'package:notifierx/notifierx_listener.dart';
import 'package:notifierx/notifierx_obs.dart';

void main() {
  runApp(
    NotifierXDependencies(
      created: const[
        create
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
      body: Builder(
        builder: (innerContext) {
          return NotifierXObs<MyAppNotifier>(
            context: innerContext,
            build: (context, notifier) {
              return Center(child: Text(notifier.message));
            },
            loading: (context, notifier) {
              return const Center(child: CircularProgressIndicator());
            },
            error: (context, notifier) {
              return const Text("Deu erro...");
            }
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (innerContext) {
          return NotifierXObs<MyAppNotifier>(
            context: innerContext,
            loading: (context, notifier) => const SizedBox.shrink(),
            build: (context, notifier) => FloatingActionButton(
              onPressed: notifier.carregar,
              child: const Icon(Icons.add),
            ),
            error: (context, notifier) => const SizedBox.shrink(),
          );
        },
      )
    );
  }
}

MyAppNotifier create() {
  return MyAppNotifier("Olá, seja bem vindo!");
}

class MyAppNotifier extends NotifierXListener {
  final String message;

  MyAppNotifier(this.message);

  @override
  void onClose() {
    return;
  }

  @override
  void onDependencies() {
    return;
  }

  @override
  void onInit() {
    carregar();

    return;
  }

  void carregar() {
    Future.value()
      .then((_) => setLoading())
      .then((_) => Future.delayed(const Duration(seconds: 5)))
      .then((_) => setReady());
  }
}