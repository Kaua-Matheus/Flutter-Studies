import 'dart:math';

import 'package:flutter/material.dart';

class Segunda extends StatefulWidget {
  const Segunda({super.key});

  @override
  State<Segunda> createState() => _SegundaState();
}

class _SegundaState extends State<Segunda> {
  @override
  Widget build(BuildContext context) {
    

    final String choice = ModalRoute.of(context)!.settings.arguments as String;

    String getRandomChoice() {
    final choices = ['pedra', 'papel', 'tesoura'];
    final randomIndex = Random().nextInt(choices.length);
    return choices[randomIndex];
  }

  final cpuChoice = getRandomChoice();

  String getResult() {
  
    if (cpuChoice == choice ) {
      return 'empatou';
    }

    if (
        cpuChoice == 'pedra' && choice == 'papel' || 
        cpuChoice == 'papel' && choice == 'tesoura' ||
        cpuChoice == 'tesoura' && choice == 'pedra'
        ) {
          return 'ganhou';
        }

    else {
      return 'perdeu';
    }
  }

  final result = getResult();

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Pedra, Papel, Tesoura'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Column (

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Column(
                children: [
                  Image.asset('../lib/assets/images/$cpuChoice.png', scale: 1.1,),
                  Text('Escolha do App: $cpuChoice'),
                ],
              ),

            SizedBox(height: 45,),

            // App decision
            
            Column(
                children: [ 
                  Image.asset('../lib/assets/images/$choice.png', scale: 1.1,),
                  Text('Sua escolha: $choice'),
                ],
              ),

            SizedBox(height: 45,),

            Column(
              children: [
                if (result == 'perdeu')
                  Image.asset('../lib/assets/images/icons8-perder-48.png', scale: 0.5),
                if (result == 'ganhou')
                  Image.asset('../lib/assets/images/icons8-vitoria-48.png', scale: 0.5),
                if (result == 'empatou')
                  Image.asset('../lib/assets/images/icons8-aperto-de-maos-100.png', scale: 0.8),
                Text('Você $result'),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/'),
                  child: Container(
                    color: Colors.amber,
                    width: 180,
                    padding: EdgeInsets.all(9),
                    child: Text("Jogar Novamente.", textAlign: TextAlign.center,)
                  ),
                )
              ],
            )

          ],
        )
      )
      
    );
  }
}