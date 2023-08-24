import 'package:equatable/equatable.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object?> get props => [];
}

class FetchMusicFiles extends MusicPlayerEvent {}
