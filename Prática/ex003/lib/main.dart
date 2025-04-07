import 'package:flutter/material.dart';
import 'package:ex003/screens/home.dart';
import 'package:ex003/screens/about.dart';

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
        '/sobre': (context) => const About(),
      },
      title: 'Petlovers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(200, 200, 200, 0)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}