import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misiclibrary/bloc/aong/song_block.dart';
import 'package:misiclibrary/screens/home_screen.dart';
import 'package:misiclibrary/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: BlocProvider(
        create: (context) => SongBloc(ApiService()),
        child: const HomeScreen(),
      ),
    );
  }
}
