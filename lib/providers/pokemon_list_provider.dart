import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/pokemon_list_response.dart';
import 'package:flutter_task/network/api_call.dart';
import 'package:flutter_task/network/api_client.dart';
import 'package:flutter_task/network/api_constants.dart';

import '../network/call_back_listeners.dart';
import '../network/method.dart';

class PokemonListProvider extends ChangeNotifier implements ApiResponse {
  List<Data> pokemonList = [];
  bool isLoading = false;

  void getPokemonList() {
    isLoading = true;
    notifyListeners();

    var params = {'pageSize': 10, 'page': 1};

    ApiCall.makeApiCall(
      ApiRequests.pokemonList,
      null,
      Method.get,
      ApiConstants.pokemonList,
      this,
      queryParameters: params,
    );
  }

  @override
  void onError(String errorResponse, int responseCode, Enum requestCode) {
    isLoading = false;
    notifyListeners();
  }

  @override
  void onResponse(String response, int responseCode, Enum requestCode) {
    //debugPrint(response);
    pokemonList =
        PokemonListResponse.fromJson(json.decode(response)).data ?? [];
    isLoading = false;
    notifyListeners();
    debugPrint('PokemonList length: ${pokemonList.length}');
  }
}
