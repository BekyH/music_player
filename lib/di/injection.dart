import 'package:get_it/get_it.dart';
import 'package:music_player/data/repostiories/music_repo_impl.dart';
import 'package:music_player/domain/repositories/music_repo.dart';
import 'package:music_player/domain/usecases/get_music_files.dart';
import 'package:music_player/presentation/bloc/music_player_bloc.dart';

final sl = GetIt.instance;
Future<void> serviceLocatorInit() async {

   // Register repositories
  sl.registerLazySingleton<MusicRepository>(() => MusicRepositoryImpl());

  // Register use cases
  sl.registerLazySingleton(() => GetMusicFiles(sl()));

  // Register BLoCs
  sl.registerFactory(() => MusicPlayerBloc(sl()));
}