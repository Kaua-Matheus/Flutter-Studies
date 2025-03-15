import 'dart:math';

import 'package:flutter/material.dart';
import 'package:aula03/screens/segunda.dart';
import 'package:flutter/rendering.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0),),
      ),
      debugShowCheckedModeBanner: false,
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

  String selectedChoice = '';

  void updateChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
  }

  String getRandomChoice() {
    final choices = ['pedra', 'papel', 'tesoura'];
    final randomIndex = Random().nextInt(choices.length);
    return choices[randomIndex];
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      // Navbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        title: Text(widget.title),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      // Main
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          // Random Choice
          GestureDetector (
            onTap: () {
              Navigator.pushNamed(context, '/segunda', arguments: getRandomChoice());
            },
            child: Column(
              children: [
                Image.asset('../lib/assets/images/padrao.png',),
                Text('Escolha aleatória'),
              ],
            )
          ),

          Row(

            mainAxisSize: MainAxisSize.min,
            
            children: [

              // Rock
              GestureDetector (
                onTap: () {
                  updateChoice("pedra");
                  Navigator.pushNamed(context, '/segunda', arguments: selectedChoice);
                },
                child: Column(
                  children: [
                    Image.asset('../lib/assets/images/pedra.png', scale: 1.5,),
                    Text('Pedra'),
                  ],
                )
              ),

              SizedBox(width: 30,),

              // Paper
              GestureDetector (
                onTap: () {
                  updateChoice("papel");
                  Navigator.pushNamed(context, '/segunda', arguments: selectedChoice);
                },

                child: Column(
                  children: [
                    Image.asset('../lib/assets/images/papel.png', scale: 1.5),
                    Text('Papel'),
                  ],

                )

              ),

              SizedBox(width: 30,),

              // Scissors
              GestureDetector (
                onTap: () {
                  updateChoice("tesoura");
                  Navigator.pushNamed(context, '/segunda', arguments: selectedChoice);
                },

                child: Column(
                  children: [
                    Image.asset('../lib/assets/images/tesoura.png', scale: 1.5),
                    Text('Tesoura'),
                  ],

                )

              ),

            ],

          )
        ]
      ),
      )

      // Footer


    );
  }
}
