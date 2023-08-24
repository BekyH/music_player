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

  const MusicPlayerLoaded(this.musicFiles);

  @override
  List<Object?> get props => [musicFiles];
}

class MusicPlayerError extends MusicPlayerState {
  final String message;

  const MusicPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
