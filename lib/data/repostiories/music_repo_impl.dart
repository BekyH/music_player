import 'dart:io';

import 'package:music_player/domain/repositories/music_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:music_player/domain/entities/audio_file.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicRepositoryImpl implements MusicRepository {
  @override
  Future<List<AudioFile>> getMusicFiles() async {
    final musicFiles = <AudioFile>[];

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      final musicDirectory =
          Directory('/storage/emulated/0/'); // Update the path as needed

      if (musicDirectory.existsSync()) {
        // print(musicDirectory);
        final musicFileList = musicDirectory.listSync(
          recursive: true,
          followLinks: false,
        );

        for (final file in musicFileList) {
          if (file is File && file.path.endsWith('.mp3')) {
            musicFiles.add(AudioFile(
              path: file.path,
              name:
                  file.path.split('/').last, // Get the file name from the path
            ));
          }
        }
      }
    } catch (e) {
      // Handle errors here
      print('Error fetching music files: $e');
    }

    return musicFiles;
  }
}
