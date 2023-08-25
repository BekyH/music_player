import 'package:flutter/material.dart';
import 'package:music_player/domain/entities/audio_file.dart';
import 'package:music_player/presentation/widgets/music_card.dart';
import 'package:music_player/presentation/widgets/music_card_with_controls.dart';

class AlbumDetailPage extends StatelessWidget {
  final String albumName;
  final List<AudioFile> albumFiles;

  const AlbumDetailPage({
    required this.albumName,
    required this.albumFiles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Detail: $albumName'),
      ),
      body: ListView.builder(
        itemCount: albumFiles.length,
        itemBuilder: (context, index) {
          return MusicCardWithControls(audioFile: albumFiles[index]);
        },
      ),
    );
  }
}
