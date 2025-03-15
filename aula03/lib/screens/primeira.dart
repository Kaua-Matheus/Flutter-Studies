import 'package:flutter/material.dart';

class Primeira extends StatefulWidget {
  const Primeira({super.key});

  @override
  State<Primeira> createState() => _PrimeiraState();
}

class _PrimeiraState extends State<Primeira> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Pedra, Papel, Tesoura'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Column (

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            GestureDetector(
              onTap: () => print("Test"),
              child: Column(
                children: [
                  Image.asset('../lib/assets/images/padrao.png', scale: 1.1,),
                  Text('Escolha do App'),
                ],
              ),
            ),

            SizedBox(height: 45,),

            // App decision
            GestureDetector(
              onTap: () => print("Test 2"),
              child: Column(
                children: [
                  Image.asset('../lib/assets/images/padrao.png', scale: 1.1,),
                  Text('Sua Escolha'),
                ],
              ),
            ),

            SizedBox(height: 45,),

            Column(
              children: [
                Image.asset('../lib/assets/images/icons8-aperto-de-maos-100.png', scale: 0.8),
                Text("Você venceu/perdeu"),
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