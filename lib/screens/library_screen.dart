import 'package:flutter/material.dart';
import '../widgets/library_section.dart';
import '../widgets/playlist_item.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        title: const Text('Library'),
        actions: [
          IconButton(icon: const Icon(Icons.cast), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.red,
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const LibrarySection(
            icon: Icons.history,
            title: 'History',
            subtitle: 'Keep track of what you watch',
          ),
          const LibrarySection(
            icon: Icons.play_arrow,
            title: 'Your videos',
            subtitle: '0 videos',
          ),
          const LibrarySection(
            icon: Icons.watch_later_outlined,
            title: 'Watch later',
            subtitle: '12 videos',
          ),
          const LibrarySection(
            icon: Icons.thumb_up_outlined,
            title: 'Liked videos',
            subtitle: '45 videos',
          ),
          const Divider(color: Colors.grey),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Playlists',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const PlaylistItem(name: 'Favorites', videoCount: '8 videos'),
          const PlaylistItem(name: 'Learning', videoCount: '15 videos'),
          const PlaylistItem(name: 'Music Mix', videoCount: '32 videos'),
          const PlaylistItem(name: 'Watch Later', videoCount: '12 videos'),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'New playlist',
                style: TextStyle(color: Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
