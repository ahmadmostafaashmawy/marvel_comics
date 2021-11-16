part of 'character_details_cubit.dart';

@immutable
abstract class CharacterDetailsState {}

class CharacterDetailsInitial extends CharacterDetailsState {}

class CharacterDetailsLoading extends CharacterDetailsState {}

class CharacterDetailsSuccess extends CharacterDetailsState {
  final List<CharacterModel> comics;

  CharacterDetailsSuccess(this.comics);
}

class CharacterDetailsFailed extends CharacterDetailsState {
  final String error;

  CharacterDetailsFailed(this.error);
}
