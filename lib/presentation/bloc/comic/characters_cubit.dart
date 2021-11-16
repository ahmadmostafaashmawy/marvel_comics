import 'package:bloc/bloc.dart';
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/comic_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final ComicRepository comicRepository;
  List<ComicModel> comics = [];

  CharactersCubit(this.comicRepository) : super(CharactersInitial());

  Future<void> getAllMarvelCharacters() async {
    emit(CharactersLoading());
    try {
      comicRepository.getComics().then((response) {
        if (response.code == 200) {
          comics = response.result.comics;
          emit(CharactersSuccess(response.result.comics));
        } else {
          emit(CharactersFailed(response.status));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(CharactersFailed(e.toString()));
    }
  }
}
