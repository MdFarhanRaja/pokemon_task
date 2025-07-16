class ApiConstants {
  static String baseUrl = 'https://api.pokemontcg.io/v2/';
  static String pokemonList = 'cards'; //page=1&pageSize=10;
  static String pokemonSearch = 'cards'; //q=name:aggron;
}

enum ApiRequests { pokemonList, pokemonSearch }
