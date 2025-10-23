import 'package:flutter/material.dart';
import 'action_button.dart';

class ShortItem extends StatelessWidget {
  final String title;
  final String channel;
  final String views;
  final String likes;
  final String? thumbnail;

  const ShortItem({
    super.key,
    required this.title,
    required this.channel,
    required this.views,
    required this.likes,
    this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: thumbnail != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(thumbnail!),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(color: Colors.grey[900]),
          child: thumbnail == null
              ? const Center(
                  child: Icon(
                    Icons.play_circle_filled,
                    size: 80,
                    color: Colors.white,
                  ),
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
        const Positioned(
          top: 40,
          left: 16,
          child: Row(
            children: [
              Icon(Icons.short_text, color: Colors.white, size: 28),
              SizedBox(width: 8),
              Text(
                'Shorts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ),
        Positioned(
          bottom: 100,
          right: 16,
          child: Column(
            children: [
              ActionButton(icon: Icons.thumb_up_outlined, label: likes),
              const SizedBox(height: 20),
              const ActionButton(
                icon: Icons.thumb_down_outlined,
                label: 'Dislike',
              ),
              const SizedBox(height: 20),
              const ActionButton(icon: Icons.comment_outlined, label: '1.2K'),
              const SizedBox(height: 20),
              const ActionButton(icon: Icons.share_outlined, label: 'Share'),
              const SizedBox(height: 20),
              const ActionButton(icon: Icons.more_vert, label: 'More'),
            ],
          ),
        ),
        Positioned(
          bottom: 100,
          left: 16,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.red,
                    child: Text(
                      channel[0],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    channel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
