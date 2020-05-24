import 'package:flutter/material.dart';
import 'package:fluttercustommusic/screen/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Music',
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}