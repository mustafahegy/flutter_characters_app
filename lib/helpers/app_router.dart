import 'package:characters_actors/business_logic/cubit/app_cubit.dart';
import 'package:characters_actors/data/apis/charactersApis.dart';
import 'package:characters_actors/data/models/character.dart';
import 'package:characters_actors/data/repositories/characters_repository.dart';
import 'package:characters_actors/presentation/screens/character_details_screen.dart';
import 'package:characters_actors/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late AppCubit appCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersApis());
    appCubit = AppCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AppCubit(charactersRepository),
            child: CharactersScreen(),
          ),
        );
      case characterDetailsRoute:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen(character: character));
    }
  }
}
