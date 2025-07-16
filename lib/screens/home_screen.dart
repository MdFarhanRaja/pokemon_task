import 'package:flutter/material.dart';
import 'package:flutter_task/providers/pokemon_list_provider.dart';
import '../base_class.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'pokemon_card_view.dart' show PokemonCardView;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseClass<HomeScreen> {
  late PokemonListProvider pokemonListProvider;

  @override
  void initState() {
    pokemonListProvider = Provider.of<PokemonListProvider>(
      context,
      listen: false,
    );
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pokemonListProvider.getPokemonList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      backgroundColor: Colors.white,
      body: Consumer<PokemonListProvider>(
        builder: (context, pokemonListProvider, child) {
          return pokemonListProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: pokemonListProvider.pokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonListProvider.pokemonList[index];
                    return PokemonCardView(pokemon: pokemon);
                  },
                ),
              );
        },
      ),
    );
  }
}
