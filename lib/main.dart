import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/audioPlayerModel.dart';
import 'package:flutter_application_1/src/theme/theme.dart';

import 'package:flutter_application_1/src/pages/musicPlayerPage.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> new AudioPlayerModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Player',
        theme: miTema,
        home: MusicPlayerPage()
      ),
    );
  }
}