import 'package:flutter/material.dart';
import 'package:flutter_task/providers/pokemon_list_provider.dart';
import '../base_class.dart';
import 'package:provider/provider.dart';
import 'fetch_more_view.dart';
import 'pokemon_card_view.dart' show PokemonCardView;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseClass<HomeScreen> {
  late PokemonListProvider pokemonListProvider;
  final ScrollController _scrollController = ScrollController();

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

    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      pokemonListProvider.getPokemonList(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
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
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount:
                            pokemonListProvider.pokemonList.length +
                            (pokemonListProvider.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= pokemonListProvider.pokemonList.length) {
                            return const FetchMoreView();
                          }
                          final pokemon =
                              pokemonListProvider.pokemonList[index];
                          return PokemonCardView(pokemon: pokemon);
                        },
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
