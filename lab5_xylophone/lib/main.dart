import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xylophone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Colorful Musical Notes")),
          ),
          backgroundColor: const Color.fromARGB(255, 246, 181, 194),
          body: Xylophone(),
        )));
  }
}

class Xylophone extends StatelessWidget {
  const Xylophone({super.key});

  void playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$soundNumber.wav'),
        mode: PlayerMode.lowLatency);
    // don't need to include path explicitly, as we are placing it inside the assets folder
  }

  Widget buildKey({required Color color, required int soundNumber}) {
    return Expanded(
        child: TextButton(
            style: TextButton.styleFrom(backgroundColor: color),
            onPressed: () {
              playSound(soundNumber);
            },
            child: Container() // div
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        buildKey(color: Colors.red, soundNumber: 1),
        buildKey(color: Colors.orange, soundNumber: 2),
        buildKey(color: Colors.yellow, soundNumber: 3),
        buildKey(color: Colors.green, soundNumber: 4),
        buildKey(color: Colors.teal, soundNumber: 5),
        buildKey(color: Colors.blue, soundNumber: 6),
        buildKey(color: Colors.purple, soundNumber: 7),
      ]),
    );
  }
}
