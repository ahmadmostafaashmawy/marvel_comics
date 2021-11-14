import 'package:bloc/bloc.dart';
import 'package:marvel_comics/domain/base_response.dart';
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:marvel_comics/domain/comic_response.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/comic_repository.dart';

part 'comic_state.dart';

class ComicCubit extends Cubit<ComicState> {
  final ComicRepository comicRepository;
  List<ComicModel> comics = [];

  ComicCubit(this.comicRepository) : super(ComicInitial());

  Future<void> getAllComics() async {
    emit(ComicLoading());
    try {
      comicRepository.getComics().then((response) {
        if (response.code == 200) {
          comics = response.result.comics;
          emit(ComicSuccess(response.result.comics));
        } else {
          emit(ComicFailed(response.status));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(ComicFailed(e.toString()));
    }
  }
}
