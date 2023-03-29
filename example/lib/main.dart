import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notifierx/notifierx_listener.dart';
import 'package:notifierx/notifierx_obs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final countNotifier = CountNotifier();
  final randomNotifier = RandomNotifier();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NotifierXObs(
                notifier: countNotifier,
                builder: (context, notifier) {
                  return Text("${notifier.count}");
                },
              ),
              NotifierXObs(
                notifier: randomNotifier,
                builder: (context, notifier) {
                  return Text("${notifier.random}");
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            countNotifier.increment();
            randomNotifier.generate();
          },
          child: const Icon(Icons.add),
        ),
      )
    );
  }
}

class CountNotifier extends NotifierXListener {
  int _count = 0;

  void increment() {
    _count++;
    notifyListeners();
  }

  get count => _count;
  
  @override
  void onClose() {
    
  }
  
  @override
  void onDependencies() {
    
  }
  
  @override
  void onInit() {
    
  }
}

class RandomNotifier extends NotifierXListener {
  int _random = 0;

  void generate() {
    _random = Random().nextInt(1000);
    notifyListeners();
  }

  get random => _random;
  
  @override
  void onClose() {
    
  }
  
  @override
  void onDependencies() {
    
  }
  
  @override
  void onInit() {
    
  }
}