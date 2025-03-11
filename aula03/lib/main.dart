import 'package:flutter/material.dart';
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
        '/': (context) => const MyHomePage(title: "Pedra, Papel, Tesoura",),
        '/segunda': (context) => const Segunda(),
        },
      title: 'Pedra, Papel, Tesoura',
      theme: ThemeData(
  
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
      
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/segunda'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
