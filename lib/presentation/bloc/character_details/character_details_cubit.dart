import 'package:bloc/bloc.dart';
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/comic_repository.dart';

part 'character_details_state.dart';

class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  final ComicRepository comicRepository;
  List<CharacterModel> comics = [];

  CharacterDetailsCubit(this.comicRepository) : super(CharacterDetailsInitial());

  Future<void> getAllComics() async {
    emit(CharacterDetailsLoading());
    try {
      comicRepository.getComics().then((response) {
        if (response.code == 200) {
          comics = response.result.comics;
          emit(CharacterDetailsSuccess(response.result.comics));
        } else {
          emit(CharacterDetailsFailed(response.status));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(CharacterDetailsFailed(e.toString()));
    }
  }
}
