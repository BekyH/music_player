import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/bloc/music_player_bloc.dart';
import 'package:music_player/presentation/bloc/music_player_event.dart';
import 'package:music_player/presentation/bloc/music_player_state.dart';
import 'package:music_player/presentation/widgets/music_card.dart';

class MusicPlayer extends StatelessWidget {
const MusicPlayer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final musicPlayerBloc = BlocProvider.of<MusicPlayerBloc>(context);

    // Dispatch an event to fetch music files when the screen is loaded
    musicPlayerBloc.add(FetchMusicFiles());

    return Scaffold(
   body: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        if (state is MusicPlayerLoading) {
          return CircularProgressIndicator();
        } else if (state is MusicPlayerLoaded) {
          final musicFiles = state.musicFiles;
           print(musicFiles.length);
            return ListView.builder(
              itemCount: musicFiles.length,
              itemBuilder: (context, index) {
                final audioFile = musicFiles[index];

                return MusicCard(audioFile: audioFile);
              },
            );
        } else if (state is MusicPlayerError) {
          return Text(state.message);
        }

        return Container(child: Text('data'),);
      },
    ));
  }
}