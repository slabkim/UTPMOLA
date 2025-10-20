import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final String name;
  final String videoCount;

  const PlaylistItem({super.key, required this.name, required this.videoCount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 80,
        height: 56,
        color: Colors.grey[800],
        child: Stack(
          children: [
            const Center(
              child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  videoCount.split(' ')[0],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      subtitle: Text(
        videoCount,
        style: TextStyle(color: Colors.grey[400], fontSize: 12),
      ),
      trailing: const Icon(Icons.more_vert, color: Colors.grey),
      onTap: () {},
    );
  }
}
