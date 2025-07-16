import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_task/models/pokemon_list_response.dart';
import 'package:flutter_task/network/api_call.dart';
import 'package:flutter_task/network/api_constants.dart';
import '../network/call_back_listeners.dart';
import '../network/method.dart';

class PokemonListProvider extends ChangeNotifier implements ApiResponse {
  List<Data> pokemonList = [];
  bool isLoading = false;
  int currentPage = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;

  void getPokemonList({bool loadMore = false}) {
    if (loadMore) {
      if (!hasMoreData || isLoadingMore) return;
      isLoadingMore = true;
      currentPage++;
    } else {
      isLoading = true;
      currentPage = 1;
      pokemonList = [];
    }
    notifyListeners();

    var params = {'pageSize': 30, 'page': currentPage};

    ApiCall.makeApiCall(
      ApiRequests.pokemonList,
      null,
      Method.get,
      ApiConstants.pokemonList,
      this,
      queryParameters: params,
    );
  }

  void resetPagination() {
    currentPage = 0;
    hasMoreData = true;
    pokemonList = [];
    notifyListeners();
  }

  List<Data> searchResults = [];
  bool isSearching = false;
  bool hasSearchError = false;
  String searchErrorMessage = '';

  bool hasListError = false;
  String listErrorMessage = '';
  int listErrorCode = 0;
  Enum? listErrorRequestType;

  void searchPokemon(String query) {
    isSearching = true;
    searchResults = [];
    hasSearchError = false;
    searchErrorMessage = '';
    notifyListeners();

    debugPrint(
      'GET Api:https://api.pokemontcg.io/v2/cards Params: {q: name:$query*}',
    );

    var params = {'q': 'name:$query*'};

    ApiCall.makeApiCall(
      ApiRequests.pokemonSearch,
      null,
      Method.get,
      ApiConstants.pokemonSearch,
      this,
      queryParameters: params,
    );
  }

  @override
  void onError(String errorResponse, int responseCode, Enum requestCode) {
    debugPrint(
      'API Error: $errorResponse, code: $responseCode, request: $requestCode',
    );

    if (requestCode == ApiRequests.pokemonSearch) {
      isSearching = false;
      hasSearchError = true;
      searchErrorMessage = 'Search failed: $errorResponse';
      debugPrint('Search error occurred: $errorResponse');
    } else {
      isLoading = false;
      isLoadingMore = false;
      hasListError = true;
      listErrorCode = responseCode;
      listErrorRequestType = requestCode;
      listErrorMessage = errorResponse;
    }

    notifyListeners();
  }

  @override
  void onResponse(String response, int responseCode, Enum requestCode) {
    //debugPrint(response);
    var newData =
        PokemonListResponse.fromJson(json.decode(response)).data ?? [];

    if (requestCode == ApiRequests.pokemonSearch) {
      searchResults = newData;
      isSearching = false;
      notifyListeners();
      debugPrint('Search results: ${searchResults.length} items found');
    } else {
      if (newData.isEmpty) {
        hasMoreData = false;
      } else {
        if (currentPage == 1) {
          pokemonList = newData;
        } else {
          pokemonList.addAll(newData);
        }
      }

      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
      debugPrint(
        'PokemonList length: ${pokemonList.length}, currentPage: $currentPage, hasMoreData: $hasMoreData',
      );
    }
  }
}
