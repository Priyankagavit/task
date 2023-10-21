import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import '../models/characters_model.dart';
import '../models/character_detail_model.dart';

class CharacterApiProvider {
  final Client client = Client();
  final String _baseUrl = "https://rickandmortyapi.com/api";

  Future<CharactersModel> fetchCharacterList(int page) async {
    Response response;

    response = await client.get(Uri.parse("$_baseUrl/character/?page=$page"));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return CharactersModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<CharacterDetailModel> fetchCharacterDetails(int movieId) async {
    final response =
        await client.get(Uri.parse("$_baseUrl/character/$movieId"));

    if (response.statusCode == 200) {
      return CharacterDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
