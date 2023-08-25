import 'package:music_player/domain/entities/audio_file.dart';

abstract class MusicRepository {
  Future<List<AudioFile>> getMusicFiles();
   Map<String, List<AudioFile>> categorizeByArtist(List<AudioFile> musicFiles);
    Map<String, List<AudioFile>> categorizeByAlbum(List<AudioFile> musicFiles);
}
