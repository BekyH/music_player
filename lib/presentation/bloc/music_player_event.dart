import 'package:equatable/equatable.dart';
import 'package:music_player/domain/entities/audio_file.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object?> get props => [];
}

class FetchMusicFiles extends MusicPlayerEvent {}
class FetchAlbums extends MusicPlayerEvent {}

class PlayMusic extends MusicPlayerEvent {
  final AudioFile audioFile;

  PlayMusic(this.audioFile);

  @override
  List<Object?> get props => [audioFile];
}

class PauseMusic extends MusicPlayerEvent {
  final AudioFile audioFile;

  PauseMusic(this.audioFile);

  @override
  List<Object?> get props => [audioFile];
}

class StopMusic extends MusicPlayerEvent {
  final AudioFile audioFile;

  StopMusic(this.audioFile);

  @override
  List<Object?> get props => [audioFile];
}