import 'package:bloc/bloc.dart';
import 'package:marvel_comics/domain/character_model.dart';
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/comic_repository.dart';

part 'character_details_state.dart';

class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  final ComicRepository comicRepository;
  List<ComicModel> comicList = [];

  CharacterDetailsCubit(this.comicRepository)
      : super(CharacterDetailsInitial());

  Future<void> getCharacterDetails(String collectionURI) async {
    emit(CharacterDetailsLoading());
    try {
      var response = await comicRepository.getCharacterDetails(collectionURI);

      if (response != null) {
        comicList = response.result.comics;
      }

      emit(CharacterDetailsSuccess(comicList));
    } catch (e) {
      print(e.toString());
      emit(CharacterDetailsFailed(e.toString()));
    }
  }
}
