import 'package:flutter/material.dart';
import 'package:lab2261/components/track_list_item.dart';
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
  @override
  void initState() {
    super.initState();
    obtenerDato();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Tracks")]);
  }

  Future<void> obtenerDato() async {
    final url = Uri.parse("https://api.deezer.com/search?q=eminem");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> tracksData = data["data"]; //Map<String, dynamic>

      //List<dynamic> -> List<Track>
      List<Track> tracks = tracksData
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
    } else {
      print("Error en la petición");
    }
  }
}
