
// MusicCardWithControls Widget for individual audio files
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/domain/entities/audio_file.dart';
import 'package:music_player/presentation/bloc/music_player_bloc.dart';
import 'package:music_player/presentation/bloc/music_player_event.dart';

class MusicCardWithControls extends StatelessWidget {
  final AudioFile audioFile;

  const MusicCardWithControls({required this.audioFile});

  @override
  Widget build(BuildContext context) {
    final musicPlayerBloc = context.read<MusicPlayerBloc>();

    return Card(
      // ... Card properties
      child: ListTile(
        // ... ListTile properties
         title: Text(
          audioFile.name!,
          style: TextStyle(fontSize: 16.sp)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                musicPlayerBloc.add(PlayMusic(audioFile));
              },
            ),
            IconButton(
              icon: Icon(Icons.pause),
              onPressed: () {
                musicPlayerBloc.add(PauseMusic(audioFile));
              },
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                musicPlayerBloc.add(StopMusic(audioFile));
              },
            ),
          ],
        ),
      ),
    );
  }
}