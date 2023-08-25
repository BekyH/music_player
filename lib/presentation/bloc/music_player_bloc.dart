import 'package:bloc/bloc.dart';
import 'package:music_player/di/injection.dart';
import 'package:music_player/domain/repositories/music_repo.dart';
import 'package:music_player/domain/usecases/get_music_files.dart';
import 'package:music_player/presentation/bloc/music_player_event.dart';
import 'package:music_player/presentation/bloc/music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final GetMusicFiles getMusicFiles;
  MusicPlayerBloc(this.getMusicFiles) : super(MusicPlayerInitial()) {
    on<FetchMusicFiles>(
      (event, emit) async {
        emit(MusicPlayerLoading());
        try {
          final musicFiles = await getMusicFiles.execute();
          final categorizedAlbums =
              sl<MusicRepository>().categorizeByAlbum(musicFiles);
          final categorizedArtists =
              sl<MusicRepository>().categorizeByArtist(musicFiles);
          emit(MusicPlayerLoaded(
            musicFiles: musicFiles,
            albums: categorizedAlbums,
            artists: categorizedArtists,
          ));
        } catch (e) {
          emit(MusicPlayerError(e.toString()));
        }
      },
    );

    on<FetchAlbums>((event, emit) async{
      final musicFiles = await sl<MusicRepository>().getMusicFiles();
      final albums =  sl<MusicRepository>().categorizeByAlbum(musicFiles);
      emit(MusicPlayerLoadedWithAlbums(musicFiles, albums));
    });
  }
}
