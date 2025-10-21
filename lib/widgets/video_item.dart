import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoItem extends StatefulWidget {
  final String title;
  final String channel;
  final String metadata;
  final String? imagePath;
  final String? videoUrl;

  const VideoItem({
    super.key,
    required this.title,
    required this.channel,
    required this.metadata,
    this.imagePath,
    this.videoUrl,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);
      if (videoId != null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      }
    }
  }

  @override
  void didUpdateWidget(covariant VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      // Pause and recreate controller if video changes
      try {
        _controller?.pause();
      } catch (_) {}
      _controller?.dispose();
      _controller = null;
      if (widget.videoUrl != null) {
        final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);
        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }
      }
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pause playback when the widget is removed from the tree to
    // prevent the underlying WebView from being used after dispose.
    try {
      _controller?.pause();
    } catch (_) {}
    super.deactivate();
  }

  @override
  void dispose() {
    try {
      _controller?.pause();
    } catch (_) {}
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[800],
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _controller != null
                ? YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.red,
                      handleColor: Colors.redAccent,
                    ),
                  )
                : widget.imagePath != null
                    ? Image.asset(
                        widget.imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 64,
                              color: Colors.white,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.red,
                child: Text(
                  widget.channel[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.channel}\n${widget.metadata}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
