import 'package:flutter/material.dart';

class Confirmacao extends StatefulWidget {
  const Confirmacao({super.key});

  @override
  State<Confirmacao> createState() => _ConfirmacaoState();
}

class _ConfirmacaoState extends State<Confirmacao> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navbar
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Confirmação"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        
      )
        
    );
  }
}