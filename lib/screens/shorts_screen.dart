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
          ),
          ShortItem(
            title: 'Funny Cat Moments 😂',
            channel: 'Pet Lovers',
            views: '1.8M',
            likes: '32K',
          ),
          ShortItem(
            title: 'Cooking Tips & Tricks',
            channel: 'Chef Master',
            views: '3.2M',
            likes: '78K',
          ),
        ],
      ),
    );
  }
}
