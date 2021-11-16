part of 'stories_cubit.dart';

@immutable
abstract class StoriesState {}

class StoriesInitial extends StoriesState {}

class StoriesLoading extends StoriesState {}

class StoriesSuccess extends StoriesState {
  final List<ComicModel> comics;

  StoriesSuccess(this.comics);
}

class StoriesFailed extends StoriesState {
  final String error;

  StoriesFailed(this.error);
}
