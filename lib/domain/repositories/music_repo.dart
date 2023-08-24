import 'package:music_player/domain/entities/audio_file.dart';

abstract class MusicRepository {
  Future<List<AudioFile>> getMusicFiles();
}
