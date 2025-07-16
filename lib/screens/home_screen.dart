import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/providers/pokemon_list_provider.dart';
import '../base_class.dart';
import 'package:provider/provider.dart';
import 'fetch_more_view.dart';
import '../widgets/animated_pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class PokemonSearch extends SearchDelegate<String> {
  final PokemonListProvider pokemonListProvider;
  String? _lastSearchQuery;

  PokemonSearch(this.pokemonListProvider);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search term', style: TextStyle(fontSize: 18)),
      );
    }

    if (!pokemonListProvider.isSearching &&
        (_lastSearchQuery != query ||
            pokemonListProvider.searchResults.isEmpty)) {
      _lastSearchQuery = query;
      pokemonListProvider.searchResults = [];
      Future.microtask(() {
        try {
          debugPrint('Starting search for: $query');
          pokemonListProvider.searchPokemon(query);
        } catch (e) {
          debugPrint('Error scheduling search: $e');
        }
      });
    }

    if (pokemonListProvider.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    return Consumer<PokemonListProvider>(
      builder: (context, provider, child) {
        if (provider.hasSearchError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'API Error: "${provider.searchErrorMessage}", code: 404, request: ApiRequests.pokemonSearch',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      query = query.substring(
                        0,
                        query.length > 1 ? query.length ~/ 2 : 1,
                      );
                      Future.microtask(() => provider.searchPokemon(query));
                    },
                    child: const Text('Try a simpler search'),
                  ),
                ],
              ),
            ),
          );
        }

        debugPrint(
          'Building search results UI: ${provider.searchResults.length} items',
        );

        if (provider.isSearching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.searchResults.isEmpty) {
          return const Center(
            child: Text('No Pokemon found!', style: TextStyle(fontSize: 18)),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              final pokemon = provider.searchResults[index];
              return AnimatedPokemonCard(pokemon: pokemon, index: index);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            query.isEmpty
                ? 'Enter Pokemon name to search'
                : 'Press search to find "$query"',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          if (query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () => showResults(context),
                child: const Text('Search Now'),
              ),
            ),
        ],
      ),
    );
  }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PokemonSearch(pokemonListProvider),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<PokemonListProvider>(
        builder: (context, pokemonListProvider, child) {
          if (pokemonListProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (pokemonListProvider.hasListError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'API Error: "${pokemonListProvider.listErrorMessage}", code: ${pokemonListProvider.listErrorCode}, request: ${pokemonListProvider.listErrorRequestType}',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        pokemonListProvider.hasListError = false;
                        pokemonListProvider.getPokemonList();
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          return Padding(
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
                      final pokemon = pokemonListProvider.pokemonList[index];
                      return AnimatedPokemonCard(
                        pokemon: pokemon,
                        index: index,
                      );
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
