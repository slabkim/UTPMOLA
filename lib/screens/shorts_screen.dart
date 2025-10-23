import 'package:flutter/material.dart';
import '../widgets/short_item.dart';

class ShortsScreen extends StatelessWidget {
  const ShortsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: const [
          ShortItem(
            title: 'Amazing Dance Performance 🔥',
            channel: 'Dance Studio',
            views: '2.5M',
            likes: '45K',
            thumbnail: 'assets/images/unbox.jpg',
          ),
          ShortItem(
            title: 'Funny Cat Moments 😂',
            channel: 'Pet Lovers',
            views: '1.8M',
            likes: '32K',
            thumbnail: 'assets/images/yoshinoya.jpg',
          ),
          ShortItem(
            title: 'Cooking Tips & Tricks',
            channel: 'Chef Master',
            views: '3.2M',
            likes: '78K',
            thumbnail: 'assets/images/windahwleo.webp',
          ),
        ],
      ),
    );
  }
}
