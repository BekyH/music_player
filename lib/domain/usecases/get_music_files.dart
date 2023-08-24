import 'package:music_player/domain/entities/audio_file.dart';
import 'package:music_player/domain/repositories/music_repo.dart';

class GetMusicFiles {
  final MusicRepository repository;

  GetMusicFiles(this.repository);

  Future<List<AudioFile>> execute() async {
    return await repository.getMusicFiles();
  }
}
