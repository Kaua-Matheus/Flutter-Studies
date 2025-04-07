import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 207, 207, 207),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(onPressed: () => Navigator.pushNamed(context, "/"), child: Text("Menu")),
          ElevatedButton(onPressed: () => Navigator.pushNamed(context, "/sobre"), child: Text("Sobre"))
        ],
      ),

      body: Center(
        child: Text("Página Sobre."),
      ),
    );
  }
}