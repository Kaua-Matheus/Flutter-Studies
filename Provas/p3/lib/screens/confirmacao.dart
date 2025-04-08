import 'package:flutter/material.dart';

class Confirmacao extends StatefulWidget {
  const Confirmacao({super.key});

  @override
  State<Confirmacao> createState() => _ConfirmacaoState();
}

class _ConfirmacaoState extends State<Confirmacao> {


  @override
  Widget build(BuildContext context) {
    
    final List<String> infos = ModalRoute.of(context)!.settings.arguments as List<String>;

    return Scaffold(
      
      // Navbar
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Confirmação"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Column(
          children: [
            Text(
              "Nome: ${infos[0]}"
            ),
            Text(
              "Idade: ${infos[1]}"
            ),

            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/', arguments: infos),
              child: Text("Editar"),
              ),
          ],
        ),
      )
        
    );
  }
}