import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String variavelTela = "";
  String ultimaOperacao = "";
  double calculo = 0;

  void adicionarNumero(String numero) {
    setState(() {
      variavelTela += numero;
    });
  }

  void calcular(String operacao) {
    double valorDouble = double.parse(variavelTela);
    if (variavelTela == "") {
      return;
    }
    ultimaOperacao = operacao;
    if (calculo == 0) {
      calculo = valorDouble;
      setState(() {
        variavelTela = "";
      });
      return;
    }
    switch (operacao) {
      case "*":
        calculo *= valorDouble;
        print(calculo);
        break;
      case "/":
        calculo /= valorDouble;
        print(calculo);
        break;
      case "+":
        calculo += valorDouble;
        print(calculo);
        break;
      case "-":
        calculo -= valorDouble;
        print(calculo);
        break;
    }

    setState(() {
      variavelTela = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 32, 32, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${variavelTela == "" ? "0" : variavelTela}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          Container(
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("7")},
                      child: Text(
                        "7",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("8")},
                      child: Text(
                        "8",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("9")},
                      child: Text(
                        "9",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(50, 50, 50, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {calcular("*")},
                      child: Text(
                        "x",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("4")},
                      child: Text(
                        "4",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("5")},
                      child: Text(
                        "5",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("6")},
                      child: Text(
                        "6",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(50, 50, 50, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {calcular("-")},
                      child: Text(
                        "-",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("1")},
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("2")},
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("3")},
                      child: Text(
                        "3",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(50, 50, 50, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {calcular("+")},
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {calcular("/")},
                      child: Text(
                        "/",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(59, 59, 59, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () => {adicionarNumero("0")},
                      child: Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(244, 67, 54, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed:
                          () => {
                            setState(() {
                              calculo = 0;
                              variavelTela = "";
                              ultimaOperacao = "";
                            }),
                          },
                      child: Text(
                        "C",
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(76, 194, 255, 1),
                        ),
                        fixedSize: WidgetStateProperty.all(Size(100, 100)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed:
                          () => {
                            calcular(ultimaOperacao),
                            setState(() {
                              variavelTela = calculo.toString();
                              calculo = 0;
                            }),
                          },
                      child: Text(
                        "=",
                        style: TextStyle(color: Colors.black, fontSize: 45),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
