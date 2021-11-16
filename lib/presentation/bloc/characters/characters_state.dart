part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersSuccess extends CharactersState {
  final List<CharacterModel> comics;

  CharactersSuccess(this.comics);
}

class CharactersFailed extends CharactersState {
  final String error;

  CharactersFailed(this.error);
}
