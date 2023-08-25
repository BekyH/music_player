import 'package:equatable/equatable.dart';
import 'package:music_player/domain/entities/audio_file.dart';

abstract class MusicPlayerState extends Equatable {
  const MusicPlayerState();

  @override
  List<Object?> get props => [];
}

class MusicPlayerInitial extends MusicPlayerState {}

class MusicPlayerLoading extends MusicPlayerState {}

class MusicPlayerLoaded extends MusicPlayerState {
  final List<AudioFile> musicFiles;
  final Map<String, List<AudioFile>> albums;
  final Map<String, List<AudioFile>> artists;

  MusicPlayerLoaded({
    required this.musicFiles,
    required this.albums,
    required this.artists,
  });

  @override
  List<Object?> get props => [musicFiles, albums, artists];
}

class MusicPlayerLoadedWithAlbums extends MusicPlayerState {
  final List<AudioFile> musicFiles;
  final Map<String, List<AudioFile>> albums;

  const MusicPlayerLoadedWithAlbums(this.musicFiles, this.albums);

  @override
  List<Object?> get props => [musicFiles, albums];
}

class MusicPlayerError extends MusicPlayerState {
  final String message;

  const MusicPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
