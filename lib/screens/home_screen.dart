
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misiclibrary/bloc/aong/Song_state.dart';
import 'package:misiclibrary/bloc/aong/song_block.dart';
import 'package:misiclibrary/bloc/aong/song_event.dart';
import 'package:misiclibrary/screens/song_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // first load
    context.read<SongBloc>().add(SearchSong("eminem"));

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {

        context.read<SongBloc>().add(LoadMoreSong());
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) {
    context.read<SongBloc>().add(SearchSong(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: "Search tracks...",
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: performSearch,
        ),
      ),

      body: BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {

          if (state is SongLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SongLoaded) {
            return ListView.builder(
              controller: scrollController,
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                return SongTile(song: state.songs[index]);
              },
            );
          }

          if (state is SongError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("Search songs"));
        },
      ),
    );
  }
}