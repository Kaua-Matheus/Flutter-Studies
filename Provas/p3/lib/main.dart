import 'package:flutter/material.dart';
import 'package:p3/screens/home.dart';
import 'package:p3/screens/confirmacao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Home(),
        '/confirmacao': (context) => const Confirmacao(),
      },
      title: 'Prova 03',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}