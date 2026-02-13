import '../../model/Song_model.dart';

abstract class SongState {}

class SongInitial extends SongState {}

class SongLoading extends SongState {
  final bool isFirstFetch;
  SongLoading({this.isFirstFetch = false});
}

class SongLoaded extends SongState {
  final List<Song> songs;
  final bool hasReachedMax;

  SongLoaded({
    required this.songs,
    this.hasReachedMax = false,
  });
}

class SongError extends SongState {
  final String message;
  SongError(this.message);
}
