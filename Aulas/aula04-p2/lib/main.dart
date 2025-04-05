import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  
  TextEditingController _input1 = new TextEditingController();
  TextEditingController _input2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding:  EdgeInsets.all(100),
              child: Column(
                children: [
                  TextFormField(
                    controller: _input1,
                    decoration: const 
                      InputDecoration(
                        labelText: 'Entrada 1',
                        border: OutlineInputBorder()
                      ),
                  ),
                  TextFormField(
                    controller: _input1,
                    decoration: const 
                      InputDecoration(
                        labelText: 'Entrada 1',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              )
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      "Enviar"
                    ),),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      "Enviar"
                    ),),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      "Enviar"
                    ),),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      "Enviar"
                    ),),
                ],
              ),
            Text("Valor")
          ],
        ),
      ),
    );
  }
}