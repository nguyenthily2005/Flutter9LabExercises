import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Magic 8 Ball")),
            backgroundColor: const Color.fromARGB(255, 247, 150, 179),
            body: MagicBallPage()));
  }
}

class MagicBallPage extends StatefulWidget {
  const MagicBallPage({super.key});

  @override
  State<StatefulWidget> createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  int number = 1;

  void shakeBall() {
    setState(() {
      number = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
                onPressed: shakeBall,
                child: Image(image: AssetImage("images/ball$number.png"))),
          )
        ],
      ),
    );
  }
}
