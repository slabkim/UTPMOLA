import 'package:flutter/material.dart';
import '../widgets/channel_avatar.dart';
import '../widgets/video_item.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        title: const Text('Subscriptions'),
        actions: [
          IconButton(icon: const Icon(Icons.cast), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          // Channel List
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                ChannelAvatar(name: 'Tech Channel', initial: 'T'),
                ChannelAvatar(name: 'Gaming Hub', initial: 'G'),
                ChannelAvatar(name: 'Music World', initial: 'M'),
                ChannelAvatar(name: 'Code Academy', initial: 'C'),
                ChannelAvatar(name: 'Sports TV', initial: 'S'),
                ChannelAvatar(name: 'News 24', initial: 'N'),
              ],
            ),
          ),
          const Divider(color: Colors.grey, height: 1),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Latest videos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VideoItem(
            title: 'New Flutter Update 2024',
            channel: 'Tech Channel',
            metadata: '856K views • 3 hours ago',
            imagePath: 'assets/images/video1.jpg',
          ),
          const VideoItem(
            title: 'Best Gaming Setup Tour',
            channel: 'Gaming Hub',
            metadata: '1.2M views • 5 hours ago',
            imagePath: 'assets/images/video2.jpg',
          ),
          const VideoItem(
            title: 'Top Music Hits of the Week',
            channel: 'Music World',
            metadata: '2.5M views • 1 day ago',
            imagePath: 'assets/images/video3.jpg',
          ),
          const VideoItem(
            title: 'Advanced Programming Tutorial',
            channel: 'Code Academy',
            metadata: '456K views • 2 days ago',
            imagePath: 'assets/images/video4.jpg',
          ),
        ],
      ),
    );
  }
}
