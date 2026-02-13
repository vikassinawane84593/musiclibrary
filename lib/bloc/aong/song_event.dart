abstract class SongEvent {}

class SearchSong extends SongEvent {
  final String query;
  SearchSong(this.query);
}

class LoadMoreSong extends SongEvent {}
