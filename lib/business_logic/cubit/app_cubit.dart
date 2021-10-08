import 'package:characters_actors/data/models/character.dart';
import 'package:characters_actors/data/repositories/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  final CharactersRepository charactersRepository;
  List<Character>? characters;

  AppCubit(this.charactersRepository) : super(AppInitialStates());

  List<Character>? getAllCharacter() {
    charactersRepository.getAllCharacter().then((characters) {
      emit(CharactersIsLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
//AppCubit get(context) => BlocProvider.of(context);
}
