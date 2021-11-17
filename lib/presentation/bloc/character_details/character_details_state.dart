part of 'character_details_cubit.dart';

@immutable
abstract class CharacterDetailsState {}

class CharacterDetailsInitial extends CharacterDetailsState {}

class CharacterDetailsLoading extends CharacterDetailsState {}

class CharacterDetailsSuccess extends CharacterDetailsState {
  final List<ComicModel> stories;
  final List<ComicModel> events;
  final List<ComicModel> series;

  CharacterDetailsSuccess(this.stories, this.events, this.series);
}

class CharacterDetailsFailed extends CharacterDetailsState {
  final String error;

  CharacterDetailsFailed(this.error);
}
