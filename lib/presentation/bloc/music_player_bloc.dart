import 'package:bloc/bloc.dart';
import 'package:music_player/domain/usecases/get_music_files.dart';
import 'package:music_player/presentation/bloc/music_player_event.dart';
import 'package:music_player/presentation/bloc/music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent,MusicPlayerState>{
    final GetMusicFiles getMusicFiles;
    MusicPlayerBloc(this.getMusicFiles):super(MusicPlayerInitial()){
      on<FetchMusicFiles>((event, emit) async{
        emit(MusicPlayerLoading());
        try{
          final musicFiles = await getMusicFiles.execute();
          emit(MusicPlayerLoaded(musicFiles));
        }
        catch(e){
          emit(MusicPlayerError(e.toString()));
        }
      },);
    }

}