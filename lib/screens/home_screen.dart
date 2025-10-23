import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/video_item.dart';
import '../widgets/category_chip.dart';
import '../providers/auth_provider.dart' as app_auth;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _buildDisplayName(String? rawName, String fallbackEmail) {
    final trimmed = rawName?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
    final localPart = fallbackEmail
        .split('@')
        .first
        .replaceAll('.', ' ')
        .trim();
    if (localPart.isEmpty) {
      return 'UTPMOLA User';
    }
    return localPart
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<app_auth.AuthProvider>(
      builder: (context, auth, child) {
        final email = auth.user?.email ?? 'pengguna@utpmola.app';
        final displayName = _buildDisplayName(auth.user?.displayName, email);
        final initial = displayName.isNotEmpty
            ? displayName[0].toUpperCase()
            : 'U';

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF0F0F0F),
            title: const Text(
              'YouTube',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.cast), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.18),
                  foregroundColor: Colors.redAccent,
                  child: Text(
                    initial,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              // Category Chips
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: const [
                    CategoryChip(label: 'All', isSelected: true),
                    CategoryChip(label: 'Music', isSelected: false),
                    CategoryChip(label: 'Gaming', isSelected: false),
                    CategoryChip(label: 'News', isSelected: false),
                    CategoryChip(label: 'Live', isSelected: false),
                    CategoryChip(label: 'Sports', isSelected: false),
                  ],
                ),
              ),
              // Video List
              const VideoItem(
                title: 'Windah charity',
                channel: 'Windah Barusadar',
                metadata: '1.2M views • 2 days ago',
                videoUrl:
                    'https://www.youtube.com/embed/VUCxTVeuBQ4?si=eJAE02_J7MFJ9lTT',
              ),
              const VideoItem(
                title:
                    'BURGER RATING 0 ! KUALITASNYA ZONK BANGET ?! - ZERO STAR 11 menit, 3 detik',
                channel: 'Mamank Kuliner',
                metadata: '856K views • 1 week ago',
                videoUrl:
                    'https://www.youtube.com/embed/7Th_HBRYZn8?si=i64u0dt0kspEL7rl',
              ),
              const VideoItem(
                title: 'Speed Try not to Laugh',
                channel: 'Kecepatan Academy',
                metadata: '2.3M views • 3 days ago',
                videoUrl:
                    'https://www.youtube.com/embed/ZIPCptw_Otg?si=fI8ZiqlMj6tG4_J4',
              ),
              const VideoItem(
                title: 'FAT CAT loosing Weight',
                channel: 'The Dodo',
                metadata: '456K views • 5 days ago',
                videoUrl:
                    'https://www.youtube.com/embed/a2L46NcA_6A?si=m3IQ3FncrTynShiY',
              ),
              const VideoItem(
                title: 'kita di khianati sherif guys',
                channel: 'MeongAug',
                metadata: '1.8M views • 1 day ago',
                videoUrl:
                    'https://www.youtube.com/embed/0olLJ5YN24s?si=_gF-sDWsGiQdyTK8',
              ),
            ],
          ),
        );
      },
    );
  }
}
