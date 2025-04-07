import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
        child: Text("Menu principal."),
      ),
    );
  }
}