// components/music_list_item.dart

import 'package:flutter/material.dart';

class Playlist {
  final String title;
  final String subtitle;
  final String imageUrl;

  const Playlist({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class MusicListItem extends StatelessWidget {
  final Playlist playlist;

  const MusicListItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.black,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(playlist.imageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlist.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  playlist.subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
