import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lab2261/model/track.dart';
import 'package:lab2261/stateholders/search_page_state.dart';

class SearchCubit extends Cubit<SearchPageState> {
  // El estado inicial se pasa al constructor de la superclase.
  SearchCubit() : super(SearchPageState());

  // Función para agregar un nuevo contacto
  Future<void> searchTrack(String searchTerm) async {
    // GET a deezer
    List<Track> tracks = await obtenerDato(searchTerm);
    emit(SearchPageState(tracks: tracks));
  }

  // 3. Modificamos obtenerDato para que acepte un query dinámico
  Future<List<Track>> obtenerDato(String query) async {
    if (query.isEmpty) return List.empty();

    final url = Uri.parse("https://api.deezer.com/search?q=$query");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> tracksData = data["data"];

      List<Track> fetchedTracks = tracksData
          .map(
            (e) => Track(
              id: e["id"],
              title: e["title"],
              artist: e["artist"]["name"],
              album: e["album"]["title"],
              coverUrl: e["album"]["cover_small"],
            ),
          )
          .toList();
      return fetchedTracks;
    } else {
      print("Error en la petición");
      return List.empty();
    }
  }
}
