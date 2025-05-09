import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova 1',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Cadastro de Usuário'),
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


  TextEditingController _campoNome = new TextEditingController();
  TextEditingController _campoIdade = new TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          children: [

            SizedBox(height: 30,),

            Text("Preencha os campos abaixo."),


            SizedBox(
              width: 200,
              child: TextField(
                    controller: _campoNome,

                    decoration: InputDecoration(
                      labelText: "Nome",
                    ),
                  ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                    controller: _campoIdade,
                    
                    decoration: InputDecoration(
                      labelText: "Idade",
                    ),
                  ),
            ),
            

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () => {}, child: Text("Cadastrar"))
          ],

        ),
      ),
    );
  }
}
