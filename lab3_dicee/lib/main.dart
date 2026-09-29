import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> with SingleTickerProviderStateMixin {
  int leftDice = 1; // Trying to change state in a StatelessWidget
  int rightDice = 1;
  late AnimationController _controller;
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void rollLeftDice() {
    _controller.forward(from: 0.0);
    setState(() {
      leftDice = Random().nextInt(6) % 6 + 1;
    });
  }

  void rollRightDice() {
    _controller.forward(from: 0.0);
    setState(() {
      rightDice = Random().nextInt(6) % 6 + 1;
    });
  }

  void rollTwoDices() {
    rollLeftDice();
    rollRightDice();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Dicee - Nguyễn Thị Ly"), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: rollLeftDice,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: RotationTransition(
                            turns: _animation,
                            child: Image.asset(
                              "images/dice$leftDice.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: rollRightDice,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: RotationTransition(
                            turns: _animation,
                            child: Image.asset(
                              "images/dice$rightDice.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: rollTwoDices,
                  child: Text(
                    "Xúc xắc - Nhấn để tung",
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
