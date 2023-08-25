import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/domain/entities/audio_file.dart';
import 'package:music_player/presentation/album_detail_page.dart';
import 'package:music_player/presentation/bloc/music_player_bloc.dart';
import 'package:music_player/presentation/bloc/music_player_event.dart';
import 'package:music_player/presentation/bloc/music_player_state.dart';
import 'package:music_player/presentation/widgets/music_card.dart';


class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicPlayerBloc = BlocProvider.of<MusicPlayerBloc>(context);

    // Dispatch an event to fetch albums when the screen is loaded
    musicPlayerBloc.add(FetchAlbums());

    return Scaffold(
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text('Music Player'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Albums'),
                Tab(text: 'Artists'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Albums Tab
              BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
                builder: (context, state) {
                  if (state is MusicPlayerLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MusicPlayerLoadedWithAlbums) {
                    final albums = state.albums;
                    return ListView.builder(
                      itemCount: albums.length,
                      itemBuilder: (context, index) {
                        String albumName = albums.keys.elementAt(index);
                        return ListTile(
                          title: Text(albumName),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AlbumDetailPage(
                                albumName: albumName,
                                albumFiles: albums[albumName]!,
                              ),
                            ));
                          },
                        );
                      },
                    );
                  } else if (state is MusicPlayerError) {
                    return Center(child: Text(state.message));
                  }
                  return Container(); // Handle other states as needed
                },
              ),

              // Artists Tab
              // Artists Tab
BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
  builder: (context, state) {
    if (state is MusicPlayerLoading) {
      return Center(child: CircularProgressIndicator());
    // } else if (state is MusicPlayerLoadedWithArtists) {
    //   final artists = state.artists;
    //   return ListView.builder(
    //     itemCount: artists.length,
    //     itemBuilder: (context, index) {
    //       String artistName = artists.keys.elementAt(index);
    //       List<AudioFile> artistFiles = artists[artistName]!;
    //       return Column(
    //         children: [
    //           ListTile(
    //             title: Text('Artist: $artistName'),
    //             onTap: () {
    //               // Navigator.of(context).push(MaterialPageRoute(
    //               //   builder: (context) => ArtistDetailPage(
    //               //     artistName: artistName,
    //               //     artistFiles: artistFiles,
    //               //   ),
    //               // ));
    //             },
    //           ),
    //           Divider(),
    //         ],
    //       );
    //     },
    //   );
    } else if (state is MusicPlayerError) {
      return Center(child: Text(state.message));
    }
    return Container(); // Handle other states as needed
  },
),

            ],
          ),
        ),
      ),
    );
  }
}
