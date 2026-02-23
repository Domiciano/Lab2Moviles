import 'package:flutter/material.dart';
import 'package:lab2261/components/music_list_item.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    const playlists = [
      Playlist(
        title: 'Chill Vibes Songs',
        subtitle: 'Playlist · Chill',
        imageUrl:
            'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4',
      ),
      Playlist(
        title: 'Cooking Playlist',
        subtitle: 'Playlist · Optimista',
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MusicListItem(playlist: playlists[0]),
          MusicListItem(playlist: playlists[1]),
        ],
      ),
    );
  }
}
