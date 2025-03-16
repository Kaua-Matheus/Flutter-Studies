import 'package:flutter/material.dart';
import 'package:aula03/screens/primeira.dart';
import 'package:aula03/screens/segunda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Primeira(),
        '/segunda': (context) => const Segunda(),
      },
      title: 'Pedra, Papel, Tesoura',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}