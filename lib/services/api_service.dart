import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musiclibrary/model/Song_model.dart';

class ApiService {
  Future<List<Song>> fetchSongs({
    required String query,
    required int index,
    int limit = 25,
  }) async {

    final url =
        "https://striveschool-api.herokuapp.com/api/deezer/search?q=$query";

    final response = await http.get(Uri.parse(url));


    final data = jsonDecode(response.body);
    List songsJson = data['data'];

    return songsJson.map((json) => Song.fromJson(json)).toList();
  }

}
