import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart' as app_auth;

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  static const _backgroundColor = Color(0xFF0F0F0F);
  static const _surfaceColor = Color(0xFF1B1B1B);

  static const List<_QuickAction> _quickActions = [
    _QuickAction(icon: Icons.switch_account, label: 'Ganti akun'),
    _QuickAction(icon: Icons.account_circle_outlined, label: 'Akun Google'),
    _QuickAction(icon: Icons.visibility_off_outlined, label: 'Mode Samaran'),
  ];

  static const List<_HistoryVideo> _historyVideos = [
    _HistoryVideo(
      title: 'The Biggest TV Unboxing Yet...',
      channel: 'Unbox Therapy',
      duration: '13.40',
      thumbnail: 'assets/images/unbox.jpg',
    ),
    _HistoryVideo(
      title: 'GILA! YOSHINOYA JUAL NASI TELUR',
      channel: 'Mamank Kuliner',
      duration: '13.37',
      thumbnail: 'assets/images/yoshinoya.jpg',
    ),
    _HistoryVideo(
      title: 'Last Minute Match Highlights',
      channel: 'Rizky Sports',
      duration: '9.12',
      thumbnail: 'assets/images/windahwleo.webp',
    ),
  ];

  static const List<_PlaylistInfo> _playlists = [
    _PlaylistInfo(title: 'Video yang disukai', privacy: 'Pribadi', count: 36),
    _PlaylistInfo(title: 'Tonton nanti', privacy: 'Pribadi', count: 6),
    _PlaylistInfo(title: 'DJ remix', privacy: 'Publik', count: 14),
  ];

  static const List<_MenuEntry> _menuEntries = [
    _MenuEntry(icon: Icons.video_collection_outlined, label: 'Video Anda'),
    _MenuEntry(icon: Icons.file_download_outlined, label: 'Download'),
    _MenuEntry(icon: Icons.local_movies_outlined, label: 'Film Anda'),
    _MenuEntry(
      icon: Icons.workspace_premium_outlined,
      label: 'Dapatkan YouTube Premium',
    ),
    _MenuEntry(icon: Icons.bar_chart_outlined, label: 'Waktu tonton'),
    _MenuEntry(icon: Icons.help_outline, label: 'Bantuan & saran'),
  ];

  Future<void> _handleLogout(BuildContext context) async {
    final navigator = Navigator.of(context);
    await context.read<app_auth.AuthProvider>().signOut();
    if (!navigator.mounted) return;
    navigator.pushNamedAndRemoveUntil('/', (route) => false);
  }

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

  String _buildHandle(String displayName) {
    final normalized = displayName
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '')
        .toLowerCase();
    if (normalized.isEmpty) {
      return '@utpmolauser';
    }
    final capitalized = normalized[0].toUpperCase() + normalized.substring(1);
    return '@$capitalized';
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<app_auth.AuthProvider>();
    final email = auth.user?.email ?? 'pengguna@utpmola.app';
    final displayName = _buildDisplayName(auth.user?.displayName, email);
    final handle = _buildHandle(displayName);
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        titleSpacing: 16,
        title: const Text(
          'Anda',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.cast), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade800,
                  foregroundColor: Colors.white,
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        handle,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white70,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Lihat channel'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < _quickActions.length; i++)
                      Padding(
                        padding: EdgeInsets.only(
                          right: i == _quickActions.length - 1 ? 0 : 12,
                        ),
                        child: _QuickActionChip(action: _quickActions[i]),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionHeader(title: 'Histori', actionLabel: 'Lihat semua'),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    _HistoryCard(data: _historyVideos[index]),
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemCount: _historyVideos.length,
              ),
            ),
            const SizedBox(height: 28),
            const _SectionHeader(title: 'Playlist', actionLabel: 'Lihat semua'),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    _PlaylistCard(data: _playlists[index]),
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemCount: _playlists.length,
              ),
            ),
            const SizedBox(height: 28),
            ..._menuEntries.map((entry) => _MenuTile(entry: entry)),
            const SizedBox(height: 12),
            const Divider(color: Colors.white10),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _handleLogout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _HistoryVideo {
  const _HistoryVideo({
    required this.title,
    required this.channel,
    required this.duration,
    required this.thumbnail,
  });

  final String title;
  final String channel;
  final String duration;
  final String thumbnail;
}

class _PlaylistInfo {
  const _PlaylistInfo({
    required this.title,
    required this.privacy,
    required this.count,
  });

  final String title;
  final String privacy;
  final int count;
}

class _MenuEntry {
  const _MenuEntry({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({required this.action});

  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(action.icon, size: 18),
      label: Text(action.label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: LibraryScreen._surfaceColor,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.data});

  final _HistoryVideo data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 220,
        color: LibraryScreen._surfaceColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                  const Positioned.fill(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white70,
                      size: 64,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        data.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.channel,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistCard extends StatelessWidget {
  const _PlaylistCard({required this.data});

  final _PlaylistInfo data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 150,
        color: LibraryScreen._surfaceColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              color: Colors.grey.shade800,
              child: const Center(
                child: Icon(
                  Icons.playlist_play,
                  color: Colors.white70,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${data.count} video - ${data.privacy}',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.entry});

  final _MenuEntry entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white.withValues(alpha: 0.06),
        child: Icon(entry.icon, color: Colors.white),
      ),
      title: Text(
        entry.label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.actionLabel});

  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: Colors.white70),
          child: Text(actionLabel),
        ),
      ],
    );
  }
}
