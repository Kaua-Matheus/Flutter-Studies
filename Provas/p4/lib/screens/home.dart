import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {


  TextEditingController _campoNome = new TextEditingController();
  TextEditingController _campoIdade = new TextEditingController();

  onSummit(){
    if (_campoIdade.text == '' || _campoNome.text == ''){
      debugPrint("Algum dos campos está vazio.");
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Um dos campos está vazio!'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Preencha todos os campos para continuar.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (double.parse(_campoIdade.text) <= 18) {
      debugPrint("A idade não pode ser menor do que 18!");
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('A idade é menor do que 18.'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Não é possível acessar sem que a idade seja maior ou igual a 18.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else {
      debugPrint("Está OK");
      Navigator.pushNamed(context, '/confirmacao', arguments: [_campoNome.text, _campoIdade.text]);
    }
  }

  @override
  Widget build(BuildContext context) {

    try {
      final List<String> infos = ModalRoute.of(context)!.settings.arguments as List<String>;
      _campoNome.text = infos[0];
      _campoIdade.text = infos[1];
    } catch (e) {
      
    }
   
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),

      appBar: AppBar(
        title: Text("Cadastro de Usuário", ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        
        child: Column(
          children: [

            SizedBox(height: 30,),

            Text("Preencha os campos abaixo.",
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            
            SizedBox(height: 20,),

            SizedBox(
              width: 260,
              child: TextField(
                    autofocus: true,
                    controller: _campoNome,
                    
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 260,
              child: TextField(
                    controller: _campoIdade,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      labelText: "Idade",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
            ),
            

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () => onSummit(), 
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromRGBO(43, 96, 253, 1),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  
                ),

                child: Text("Cadastrar",
                  style: TextStyle(color: Colors.white),
                ),
            ),

            

          ],

        ),
      ),
    );
  }
}
