import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_comics/constants/strings.dart';
import 'package:marvel_comics/domain/character_model.dart';
import 'package:marvel_comics/presentation/bloc/character_details/character_details_cubit.dart';
import 'package:marvel_comics/presentation/bloc/characters/characters_cubit.dart';
import 'package:marvel_comics/presentation/screen/details_screen.dart';
import 'package:marvel_comics/presentation/screen/home_screen.dart';
import 'data/repository/comic_repository.dart';
import 'data/web_services/comic_web_services.dart';
import 'presentation/screen/splash_screen.dart';

class AppRouter {
  ComicRepository comicRepository;
  CharactersCubit comicCubit;

  AppRouter() {
    comicRepository = ComicRepository(ComicWebServices());
    comicCubit = CharactersCubit(comicRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => comicCubit,
            child: const HomeScreen(),
          ),
        );

      case detailsScreen:
        final character = settings.arguments as CharacterModel;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharacterDetailsCubit(comicRepository),
            child: DetailsScreen(character),
          ),
        );
    }
  }
}
