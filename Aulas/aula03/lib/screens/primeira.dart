import 'dart:math';
import 'package:flutter/material.dart';

class Primeira extends StatefulWidget {
  const Primeira({super.key});

  @override
  State<Primeira> createState() => _PrimeiraState();
}

class _PrimeiraState extends State<Primeira> {
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
        title: Text('Pedra, Papel, Tesoura'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            // Escolha Aleatória
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/segunda', arguments: getRandomChoice());
              },
              child: Column(
                children: [
                  Image.asset('../lib/assets/images/padrao.png'),
                  Text('Escolha aleatória'),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Pedra
                GestureDetector(
                  onTap: () {
                    updateChoice('pedra');
                    Navigator.pushNamed(context, '/segunda', arguments: selectedChoice);
                  },
                  child: Column(
                    children: [
                      Image.asset('../lib/assets/images/pedra.png', scale: 1.5),
                      Text('Pedra'),
                    ],
                  ),
                ),

                SizedBox(width: 30),

                // Papel
                GestureDetector(
                  onTap: () {
                    updateChoice('papel');
                    Navigator.pushNamed(context, '/segunda', arguments: selectedChoice);
                  },
                  child: Column(
                    children: [
                      Image.asset('../lib/assets/images/papel.png', scale: 1.5),
                      Text('Papel'),
                    ],
                  ),
                ),

                SizedBox(width: 30),

                // Tesoura
                GestureDetector(
                  onTap: () {
                    updateChoice('tesoura');
                    Navigator.pushNamed(context, '/segunda', arguments: selectedChoice);
                  },
                  child: Column(
                    children: [
                      Image.asset('../lib/assets/images/tesoura.png', scale: 1.5),
                      Text('Tesoura'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}