

import 'package:bloc/bloc.dart';
import 'package:musiclibrary/bloc/aong/Song_state.dart';
import 'package:musiclibrary/bloc/aong/song_event.dart';
import 'package:musiclibrary/model/Song_model.dart';
import 'package:musiclibrary/services/api_service.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final ApiService apiService;

  int index = 0;
  String currentQuery = "";
  List<Song> allSongs = [];
  bool hasReachedMax = false;

  SongBloc(this.apiService) : super(SongInitial()) {

    on<SearchSong>((event, emit) async {
      try {
        emit(SongLoading(isFirstFetch: true));

        index = 0;
        currentQuery = event.query;
        hasReachedMax = false;

        final songs = await apiService.fetchSongs(
          query: currentQuery,
          index: index,
        );

        allSongs = songs;

        emit(SongLoaded(songs: allSongs, hasReachedMax: songs.isEmpty));

      } catch (e) {
        emit(SongError("Failed to load songs"));
      }
    });


    on<LoadMoreSong>((event, emit) async {

      if (hasReachedMax || state is SongLoading) return;

      try {
        emit(SongLoading());

        index += 25;

        final songs = await apiService.fetchSongs(
          query: currentQuery,
          index: index,
        );

        if (songs.isEmpty) {
          hasReachedMax = true;
        } else {
          allSongs.addAll(songs);
        }

        emit(SongLoaded(songs: allSongs, hasReachedMax: hasReachedMax));

      } catch (e) {
        emit(SongError("Failed to load more songs"));
      }
    });

  }
}
