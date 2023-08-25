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
            String albumName = 'Unknown Album';
            String artistName = 'Unknown Artist';
            musicFiles.add(AudioFile(
              path: file.path,
              name: file.path.split('/').last,
              albumName: albumName,
              artistName: artistName, // Get the file name from the path
            ));
          }
        }

        Map<String, List<AudioFile>> albums = {};
        Map<String, List<AudioFile>> artists = {};

        musicFiles.forEach((audioFile) {
          albums.putIfAbsent(audioFile.albumName, () => []).add(audioFile);
          artists.putIfAbsent(audioFile.artistName, () => []).add(audioFile);
        });
      }
    } catch (e) {
      // Handle errors here
      print('Error fetching music files: $e');
    }

    return musicFiles;
  }

  Map<String, List<AudioFile>> categorizeByArtist(List<AudioFile> musicFiles) {
    Map<String, List<AudioFile>> artistMap = {};

    for (var musicFile in musicFiles) {
      String artistName = getArtistFromPath(musicFile.path);
      if (artistMap.containsKey(artistName)) {
        artistMap[artistName]!.add(musicFile);
      } else {
        artistMap[artistName] = [musicFile];
      }
    }

    return artistMap;
  }

 String getArtistFromPath(String path) {
  List<String> parts = path.split('/');
  for (int i = 0; i < parts.length; i++) {
    if (parts[i] == 'Music' && i + 2 < parts.length) {
      return parts[i + 2]; // Return the part after 'Music'
    }
  }
  return 'Unknown Artist'; // Default if artist is not found
}

   Map<String, List<AudioFile>> categorizeByAlbum(List<AudioFile> musicFiles) {
    Map<String, List<AudioFile>> albumMap = {};

    for (var musicFile in musicFiles) {
      String albumName = getAlbumFromPath(musicFile.path);
      if (albumMap.containsKey(albumName)) {
        albumMap[albumName]!.add(musicFile);
      } else {
        albumMap[albumName] = [musicFile];
      }
    }

    return albumMap;
  }

 String getAlbumFromPath(String path) {
  List<String> parts = path.split('/');
  for (int i = 0; i < parts.length; i++) {
    if (parts[i] == 'Music' && i + 1 < parts.length) {
      return parts[i + 1]; // Return the part after 'Music'
    }
  }
  return 'Unknown Album'; // Default if album is not found
}

}


