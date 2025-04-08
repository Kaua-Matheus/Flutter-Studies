import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {


  TextEditingController _campoNome = new TextEditingController();
  TextEditingController _campoIdade = new TextEditingController();

  Submmit(){
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
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cadastro de Usuário"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        
        child: Column(
          children: [

            SizedBox(height: 30,),

            Text("Preencha os campos abaixo."),


            SizedBox(
              width: 200,
              child: TextField(
                    
                    controller: _campoNome,
                    decoration: InputDecoration(
                      labelText: "Nome",
                    ),
                  ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                    controller: _campoIdade,
                    
                    decoration: InputDecoration(
                      labelText: "Idade",
                    ),
                  ),
            ),
            

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () => Submmit(), child: Text("Cadastrar")),

            

          ],

        ),
      ),
    );
  }
}
