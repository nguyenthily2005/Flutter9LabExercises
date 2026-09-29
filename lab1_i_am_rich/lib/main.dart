import 'package:flutter/material.dart';

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
      title: 'I Am Rich',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Hello world"),
      //   ),
      // )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 177, 196),
        appBar: AppBar(
          title: const Text(
            "I am Rich!",
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 36,
              // fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              wordSpacing: 5.0,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 247, 81, 156),
          foregroundColor: Colors.white,
          toolbarHeight: 100,
        ),
        body: Center(
          child: Image(
            image: AssetImage("images/diamond.png"),
            width: 400,
          ),
        ),
      ),
    );
  }
}
