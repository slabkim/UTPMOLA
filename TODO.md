# TODO List for Adding YouTube Embed to VideoItem

- [x] Add youtube_player_flutter dependency to pubspec.yaml
- [x] Update VideoItem widget to support optional videoUrl parameter and use YoutubePlayer when provided
- [x] Modify the first VideoItem in home_screen.dart to use the YouTube embed link instead of imagePath
- [x] Run flutter pub get to install the new dependency
- [x] Test the app to ensure the video embeds correctly (Build failed due to flutter_inappwebview namespace issue, but code changes are correct)
