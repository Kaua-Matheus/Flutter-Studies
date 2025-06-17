import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        cardColor: Color(0xFF1E1E1E),
      ),
      home: PokedexScreen(),
      debugShowCheckedModeBanner: false
    );
  }
}

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<dynamic> pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        pokemonList = data['results'];
      });
    }
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(int id) async {
    final pokemonResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    final speciesResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id'));
    if (pokemonResponse.statusCode == 200 && speciesResponse.statusCode == 200) {
      final pokemonData = jsonDecode(pokemonResponse.body);
      final speciesData = jsonDecode(speciesResponse.body);
      return {
        'id': id,
        'name': pokemonData['name'],
        'image': pokemonData['sprites']['other']['official-artwork']['front_default'],
        'types': pokemonData['types'].map((t) => t['type']['name']).toList(),
        'description': speciesData['flavor_text_entries']
            .firstWhere((entry) => entry['language']['name'] == 'pt',
                orElse: () => null)?['flavor_text']?.replaceAll('\n', ' ') ?? 'Descrição não disponível.',
      };
    }
    return {};
  }

  void openPokemonDetails(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(pokemonId: id),
      ),
    );
  }

  final Map<String, Color> typeColors = {
    'grass': Color(0xFF4CAF50),
    'fire': Color(0xFFE53935),
    'water': Color(0xFF1976D2),
    'poison': Color(0xFF7B1FA2),
    'electric': Color(0xFFFF8F00),
    'ground': Color(0xFF5D4037),
    'rock': Color(0xFF424242),
    'bug': Color(0xFF689F38),
    'normal': Color(0xFF757575),
    'fighting': Color(0xFFD84315),
    'psychic': Color(0xFFAD1457),
    'ghost': Color(0xFF512DA8),
    'dragon': Color(0xFF303F9F),
    'fairy': Color(0xFFE91E63),
    'ice': Color(0xFF0097A7),
    'flying': Color(0xFF5E35B1),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.catching_pokemon, color: Colors.white),
            ),
            SizedBox(width: 12),
            Text('Pokédex', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ],
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 4,
      ),
      body: pokemonList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.red),
                  SizedBox(height: 16),
                  Text('Carregando Pokémons...', style: TextStyle(color: Colors.white70)),
                ],
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final id = index + 1;
                return FutureBuilder<Map<String, dynamic>>(
                  future: fetchPokemonDetails(id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(child: CircularProgressIndicator(color: Colors.red)),
                      );
                    }
                    final details = snapshot.data!;
                    final type = (details['types'] as List).isNotEmpty ? details['types'][0] : 'normal';
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            typeColors[type]?.withOpacity(0.8) ?? Colors.grey,
                            typeColors[type] ?? Colors.grey,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: typeColors[type]?.withOpacity(0.3) ?? Colors.grey.withOpacity(0.3),
                            offset: Offset(0, 8),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => openPokemonDetails(id),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '#${id.toString().padLeft(3, '0')}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.favorite_border, color: Colors.white70, size: 20),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Flexible(
                                  child: Hero(
                                    tag: 'pokemon-$id',
                                    child: CachedNetworkImage(
                                      imageUrl: details['image'] ?? '',
                                      placeholder: (context, url) => CircularProgressIndicator(color: Colors.white),
                                      errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  details['name']?.toString().toUpperCase() ?? 'Unknown',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 3,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                Wrap(
                                  spacing: 4,
                                  children: (details['types'] as List).take(2).map<Widget>((type) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        type.toString().toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PokemonDetailScreen extends StatefulWidget {
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  Map<String, dynamic> pokemonData = {};
  List<int> evolutionChain = [];
  bool isLoading = true;

  final Map<String, Color> typeColors = {
    'grass': Color(0xFF4CAF50),
    'fire': Color(0xFFE53935),
    'water': Color(0xFF1976D2),
    'poison': Color(0xFF7B1FA2),
    'electric': Color(0xFFFF8F00),
    'ground': Color(0xFF5D4037),
    'rock': Color(0xFF424242),
    'bug': Color(0xFF689F38),
    'normal': Color(0xFF757575),
    'fighting': Color(0xFFD84315),
    'psychic': Color(0xFFAD1457),
    'ghost': Color(0xFF512DA8),
    'dragon': Color(0xFF303F9F),
    'fairy': Color(0xFFE91E63),
    'ice': Color(0xFF0097A7),
    'flying': Color(0xFF5E35B1),
  };

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    final pokemonResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${widget.pokemonId}'));
    final speciesResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/${widget.pokemonId}'));
    
    if (pokemonResponse.statusCode == 200 && speciesResponse.statusCode == 200) {
      final pokemon = jsonDecode(pokemonResponse.body);
      final species = jsonDecode(speciesResponse.body);
      
      // Buscar cadeia de evolução
      await fetchEvolutionChain(species['evolution_chain']['url']);
      
      setState(() {
        pokemonData = {
          'id': pokemon['id'],
          'name': pokemon['name'],
          'image': pokemon['sprites']['other']['official-artwork']['front_default'],
          'pixelImage': 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['id']}.png',
          'types': pokemon['types'].map((t) => t['type']['name']).toList(),
          'height': pokemon['height'],
          'weight': pokemon['weight'],
          'abilities': pokemon['abilities'].map((a) => a['ability']['name']).toList(),
          'stats': pokemon['stats'],
          'description': () {
            var ptEntry = species['flavor_text_entries']
                .firstWhere((entry) => entry['language']['name'] == 'pt', orElse: () => null);
            if (ptEntry != null) return ptEntry['flavor_text'].replaceAll('\n', ' ');
            
            var enEntry = species['flavor_text_entries']
                .firstWhere((entry) => entry['language']['name'] == 'en', orElse: () => null);
            return enEntry?['flavor_text']?.replaceAll('\n', ' ') ?? 'Descrição não disponível.';
          }(),
        };
        isLoading = false;
      });
    }
  }

  Future<void> fetchEvolutionChain(String evolutionUrl) async {
    try {
      final response = await http.get(Uri.parse(evolutionUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<int> chain = [];
        
        void extractEvolutions(dynamic evolution) {
          String url = evolution['species']['url'];
          int id = int.parse(url.split('/')[6]);
          chain.add(id);
          
          for (var nextEvolution in evolution['evolves_to']) {
            extractEvolutions(nextEvolution);
          }
        }
        
        extractEvolutions(data['chain']);
        evolutionChain = chain;
      }
    } catch (e) {
      evolutionChain = [widget.pokemonId];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        appBar: AppBar(
          title: Text('Carregando...'),
          backgroundColor: Color(0xFF1E1E1E),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.red),
              SizedBox(height: 16),
              Text('Carregando dados do Pokémon...', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    final primaryType = pokemonData['types'][0];
    
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: typeColors[primaryType],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      typeColors[primaryType]?.withOpacity(0.8) ?? Colors.grey,
                      typeColors[primaryType] ?? Colors.grey,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '#${pokemonData['id'].toString().padLeft(3, '0')}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Hero(
                      tag: 'pokemon-${widget.pokemonId}',
                      child: SizedBox(
                        width: 160,
                        height: 160,
                        child: CachedNetworkImage(
                          imageUrl: pokemonData['image'] ?? '',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => SizedBox(
                            width: 160,
                            height: 160,
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                          errorWidget: (context, url, error) => SizedBox(
                            width: 160,
                            height: 160,
                            child: Icon(Icons.error, size: 100, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                pokemonData['name']?.toString().toUpperCase() ?? 'Unknown',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(offset: Offset(1, 1), blurRadius: 3, color: Colors.black54),
                  ],
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Tipos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (pokemonData['types'] as List).map<Widget>((type) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: typeColors[type],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: typeColors[type]?.withOpacity(0.4) ?? Colors.grey.withOpacity(0.4),
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        type.toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: 24),
                
                // Evoluções em Pixel Art
                if (evolutionChain.length > 1) ...[
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: typeColors[primaryType]?.withOpacity(0.3) ?? Colors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.auto_awesome, color: typeColors[primaryType]),
                            SizedBox(width: 8),
                            Text(
                              'Linha Evolutiva',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: evolutionChain.map((id) {
                            return GestureDetector(
                              onTap: () {
                                if (id != widget.pokemonId) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PokemonDetailScreen(pokemonId: id),
                                    ),
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: id == widget.pokemonId ? typeColors[primaryType]?.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: id == widget.pokemonId ? typeColors[primaryType] ?? Colors.grey : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
                                      width: 60,
                                      height: 60,
                                      placeholder: (context, url) => SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '#${id.toString().padLeft(3, '0')}',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: id == widget.pokemonId ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
                
                // Descrição
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description, color: typeColors[primaryType]),
                          SizedBox(width: 8),
                          Text(
                            'Descrição',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        pokemonData['description'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Informações Físicas
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.height, color: typeColors[primaryType], size: 30),
                            SizedBox(height: 8),
                            Text('Altura', style: TextStyle(color: Colors.white70)),
                            Text(
                              '${(pokemonData['height'] / 10).toStringAsFixed(1)} m',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.monitor_weight, color: typeColors[primaryType], size: 30),
                            SizedBox(height: 8),
                            Text('Peso', style: TextStyle(color: Colors.white70)),
                            Text(
                              '${(pokemonData['weight'] / 10).toStringAsFixed(1)} kg',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20),
                
                // Habilidades
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.psychology, color: typeColors[primaryType]),
                          SizedBox(width: 8),
                          Text(
                            'Habilidades',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (pokemonData['abilities'] as List).map<Widget>((ability) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  typeColors[primaryType]?.withOpacity(0.8) ?? Colors.blue.withOpacity(0.8),
                                  typeColors[primaryType] ?? Colors.blue,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              ability.toString().replaceAll('-', ' ').toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Estatísticas
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bar_chart, color: typeColors[primaryType]),
                          SizedBox(width: 8),
                          Text(
                            'Estatísticas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ...(pokemonData['stats'] as List).map<Widget>((stat) {
                        final statName = stat['stat']['name'].toString().replaceAll('-', ' ').toUpperCase();
                        final statValue = stat['base_stat'];
                        final percentage = (statValue / 255).clamp(0.0, 1.0);
                        
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      statName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    statValue.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: percentage,
                                backgroundColor: Colors.grey[700],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  typeColors[primaryType] ?? Colors.blue,
                                ),
                                minHeight: 8,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                
                SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}