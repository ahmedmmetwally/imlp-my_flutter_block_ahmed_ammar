import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_block_mohammady/representation/screens/character_screeen.dart';
import 'package:my_flutter_block_mohammady/representation/screens/characters_details_screeen.dart';

import 'business_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/character_web_services.dart';

class AppRouter {
  CharacterRepository? characterRepository;
  CharactersCubit? charactersCubit;

//,this.charactersCubit(characterRepository),CharacterScreen()
  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServieces());
    charactersCubit = CharactersCubit(characterRepository!);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (BuildContext context) => charactersCubit!, child: CharacterScreen(),
                ));
      case characterDetailsScreen:
        final character=settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(create: (BuildContext context)=>CharactersCubit(characterRepository!),
              child: CharactersDetailsScreen(character: character,),));
    }
  }
}
