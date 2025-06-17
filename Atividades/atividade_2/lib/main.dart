import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Busca por usuário.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class User {

  final int status;
  final String name;
  final String email;
  final String foto;

  User(
    {
      required this.status,
      required this.name,
      required this.email,
      required this.foto,
    }
  );
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _textController = TextEditingController();
  User? user;

  getAPI(String id) async {

    try {
      var actuallyResponse = await http.get(Uri.parse("https://reqres.in/api/users/$id"));

      var decodedResponse = jsonDecode(utf8.decode(actuallyResponse.bodyBytes)) as Map;
      var status = actuallyResponse.statusCode;

      if (status == 200) {

        var userData = User(
        status: status, 
        name: decodedResponse['data']['first_name'], 
        email: decodedResponse['data']['email'], 
        foto: decodedResponse['data']['avatar']
        );

        setState(() {
          user = userData;
        });
      } else {

        var userData = User(
          status: status, 
          name: 'Usuário não encontrado', 
          email: 'Usuário não encontrado', 
          foto: 'Usuário não encontrado',
        );

        setState(() {
            user = userData;
        });
      }

    } catch(e) {
      debugPrint("$e");
      var userData = User(
          status: 404, 
          name: 'Usuário não encontrado', 
          email: 'Usuário não encontrado', 
          foto: 'Usuário não encontrado',
        );

        setState(() {
            user = userData;
        });
      return e;
    }}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Center(

        // Adição de Padding
        child: Padding(
          padding: EdgeInsets.all(10),
            child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                    )
                  ]
                ),
                child: Text(
                  "Para começar a busca pelo usuário, digite um número de 1 a 12 e clique em 'buscar', um usuário será retornado.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple
                  ),
                ),
              ),

            SizedBox(
              width: 200,
              child: 
              // Campo de Texto
              TextField(controller: _textController,),
            ),

            ElevatedButton(
              onPressed: () => getAPI(_textController.text),
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              // Radius do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              ),
              child: const Text(
              "Buscar",
              style: TextStyle(color: Colors.deepPurple),
              ),
            ),

            SizedBox(height: 20,),

            user == null || user!.status == 404 ? Column(
              children: [Text(
                "Usuário não encontrado!"
              )],
            ) : Column(
                children: [
                Text("Nome: ${user!.name}"),
                Text("Email: ${user!.email}"),
                LayoutBuilder(
                  builder: (context, constraints) {
                  double imageWidth = (constraints.maxWidth) * 0.2;
                  return Image.network(
                    user!.foto,
                    width: imageWidth,
                    height: imageWidth,
                    fit: BoxFit.cover,
                  );
                  },
                ),
              ],
            ),
          ],
          )
        ),
      ),
    );
  }
}
