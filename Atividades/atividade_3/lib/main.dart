import 'dart:math';

import 'package:flutter/material.dart';
import 'package:atividade_3/assets/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lojinha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const MyHomePage(title: 'Página de produtos'),
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

  final List<Product> produtos = [
    Product(
      name: 'Foto 1', 
      price: Random().nextInt(100).toDouble() + 1, 
      image: 'https://picsum.photos/id/10/800/1200'),
    Product(
      name: 'Foto 2', 
      price: Random().nextInt(100).toDouble() + 1, 
      image: 'https://picsum.photos/id/98/800/1200'),
    Product(
      name: 'Foto 3', 
      price: Random().nextInt(100).toDouble() + 1, 
      image: 'https://picsum.photos/id/102/800/1200'),
    Product(
      name: 'Foto 4', 
      price: Random().nextInt(100).toDouble() + 1, 
      image: 'https://picsum.photos/id/103/800/1200'),
    Product(
      name: 'Foto 5', 
      price: Random().nextInt(100).toDouble() + 1, 
      image: 'https://picsum.photos/id/104/800/1200'),
  ];

  void _mostrarDetalhesProduto(BuildContext context, Product produto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detalhes do Produto',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              SizedBox(height: 20),
              
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    produto.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              SizedBox(height: 24),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Text(
                          'Preço:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'R\$ ${produto.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
       itemCount: produtos.length,
       itemBuilder: (context, index) {
         final produto = produtos[index];
         return  ListTile(
           leading: CircleAvatar(
             backgroundImage: NetworkImage(produto.image),
           ),
           title: Text(produto.name),
           subtitle: Text("R\$ ${produto.price.toStringAsFixed(2)}"),
           onTap: () => _mostrarDetalhesProduto(context, produto),
         );
       },
     ),

    );
  }
}
