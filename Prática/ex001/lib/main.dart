import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Login de Usuário'),
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
  TextEditingController _campoLogin = new TextEditingController();
  TextEditingController _campoPassword = new TextEditingController();

  bool eyeIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _campoLogin,
                    decoration: InputDecoration(
                      labelText: "Login",
                      fillColor: Colors.red,
                    ),
                  ),
                  TextField(
                    obscureText: eyeIcon,
                    keyboardType: TextInputType.text,
                    controller: _campoPassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.red,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => 
                          eyeIcon = !eyeIcon
                          ),
                        icon: Icon(
                          eyeIcon ? Icons.visibility : Icons.visibility_off
                        )
                      )
                    ),
                  ),

                  ElevatedButton(
                    onPressed:
                        () => {
                          print({
                            " Login ": _campoLogin.text,
                            " Senha ": _campoPassword.text,
                          }),
                        },
                    child: Text("Enviar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), 
    );
  }
}
