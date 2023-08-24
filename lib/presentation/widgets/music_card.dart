import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/domain/entities/audio_file.dart';

class MusicCard extends StatelessWidget {
   final AudioFile audioFile;
const MusicCard({ Key? key, required this.audioFile }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: ListTile(
        title: Text(
          audioFile.name!,
          style: TextStyle(fontSize: 16.sp),
        ),
        leading: Icon(Icons.music_note),
        trailing: IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            // Handle share action here
            // You can use the 'share' package or any other method
          },
        ),
      ),
    );
  }
}






