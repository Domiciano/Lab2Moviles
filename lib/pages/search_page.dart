import 'package:flutter/material.dart';
import 'package:lab2261/components/track_list_item.dart';
import 'package:lab2261/modal/search_modal.dart';
import 'package:lab2261/model/track.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Track> tracks = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carga inicial por defecto
    obtenerDato("eminem");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 2. Añadimos la Row de búsqueda en la parte superior
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Buscar canción...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: () {
                  // Ejecutamos la búsqueda con lo que haya en el TextField
                  obtenerDato(_searchController.text);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        ElevatedButton(onPressed: () {}, child: Text("Buscar con modal")),

        // Lista de resultados
        Expanded(
          child: tracks.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    return TrackListItem(track: tracks[index]);
                  },
                ),
        ),
      ],
    );
  }

  // 3. Modificamos obtenerDato para que acepte un query dinámico
  Future<void> obtenerDato(String query) async {
    if (query.isEmpty) return;

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

      setState(() {
        tracks = fetchedTracks;
      });
    } else {
      print("Error en la petición");
    }
  }

  // Función del modal (opcional si ya usas el buscador de arriba)
  void showSearchModal(BuildContext context) async {
    final String? searchTerm = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      builder: (context) => const SearchModal(),
    );
    print(searchTerm);
  }
}
