import 'package:flutter/material.dart';
import 'package:p4/screens/home.dart';
import 'package:p4/screens/confirmacao.dart';

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
      title: 'Prova 04',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}