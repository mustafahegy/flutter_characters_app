
import 'package:characters_actors/data/apis/charactersApis.dart';
import 'package:characters_actors/data/models/character.dart';

class CharactersRepository {

  CharactersApis? charactersApis;

  CharactersRepository(this.charactersApis);

  Future<List<Character>> getAllCharacter() async {
    final characters = await charactersApis!.getAllCharacter();
    return characters.map((character) => Character.fromJson(character)).toList();
  }
}