part of 'comic_cubit.dart';

@immutable
abstract class ComicState {}

class ComicInitial extends ComicState {}

class ComicLoading extends ComicState {}

class ComicSuccess extends ComicState {
  final List<ComicModel> comics;

  ComicSuccess(this.comics);
}

class ComicFailed extends ComicState {
  final String error;

  ComicFailed(this.error);
}
