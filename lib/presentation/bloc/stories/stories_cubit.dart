import 'package:bloc/bloc.dart';
import 'package:marvel_comics/domain/comic_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/comic_repository.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final ComicRepository comicRepository;
  List<ComicModel> comics = [];

  StoriesCubit(this.comicRepository) : super(StoriesInitial());

  Future<void> getAllComics() async {
    emit(StoriesLoading());
    try {
      comicRepository.getComics().then((response) {
        if (response.code == 200) {
          comics = response.result.comics;
          emit(StoriesSuccess(response.result.comics));
        } else {
          emit(StoriesFailed(response.status));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(StoriesFailed(e.toString()));
    }
  }
}
