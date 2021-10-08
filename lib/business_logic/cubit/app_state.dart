import 'package:characters_actors/data/models/character.dart';

abstract class AppStates {}

class AppInitialStates extends AppStates {}

class CharactersIsLoaded extends AppStates {
  final List<Character> charecters;

  CharactersIsLoaded(this.charecters);
}
