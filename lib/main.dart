import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player/di/injection.dart';
import 'package:music_player/presentation/bloc/music_player_bloc.dart';
import 'package:music_player/presentation/bloc/music_player_state.dart';
import 'package:music_player/presentation/music_player.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await serviceLocatorInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
        BlocProvider<MusicPlayerBloc>(
          create: (_) => sl<MusicPlayerBloc>(),
        ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 920),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                title: 'Porto',
                debugShowCheckedModeBanner: false,
                home: MusicPlayer(),
            );
          },
        ));
  }
}

