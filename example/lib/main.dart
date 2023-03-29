import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_listener.dart';
import 'package:notifierx/notifierx_obs.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierXObs(
      notifier: MyAppNotifier(),
      build: (context, notifier) {
        return const Text("Carregou");
      },
      loading: (context, notifier) {
        return const Text("Carregando...");
      },
      error: (context, notifier) {
        return const Text("Deu erro...");
      }
    );
  }
}

class MyAppNotifier extends NotifierXListener {
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
    Future.value()
      .then((_) => setLoading())
      .then((_) => Future.delayed(const Duration(seconds: 5)))
      .then((_) => setReady())
      .then((_) => Future.delayed(const Duration(seconds: 5)))
      .then((_) => setError());

    return;
  }
}