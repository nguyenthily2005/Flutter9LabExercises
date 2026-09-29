import 'package:flutter/material.dart';
import 'package:lab7_destini/story.dart';
import 'package:lab7_destini/story_brain.dart';

void main() => runApp(DestiniApp());

class DestiniApp extends StatelessWidget {
  const DestiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final StoryBrain brain = StoryBrain();
  late Story story;

  @override
  Widget build(BuildContext context) {
    story = brain.currentStory;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 165, 194),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  story.storyText,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Choices buttons
            if (story.choices.isNotEmpty)
              ...story.choices.map(
                (choice) => _ChoiceButton(
                  text: choice.choiceText,
                  color: const Color.fromARGB(255, 251, 117, 182),
                  onTap: () => _next(choice),
                ),
              ),
            TextButton(
              onPressed: () => setState(() => brain.undo()),
              child: const Text('Quay lại',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            ),
            // Restart button if the story ends
            if (brain.isEnd)
              TextButton(
                onPressed: () => setState(brain.restart),
                child: const Text('Restart',
                    style: TextStyle(color: Color.fromARGB(255, 241, 70, 135))),
              ),
          ],
        ),
      ),
    );
  }

  void _next(Choice choice) {
    setState(() => brain.choose(story.choices.indexOf(choice)));
  }
}

class _ChoiceButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _ChoiceButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: color,
            ),
            child: Text(text, style: const TextStyle(fontSize: 18)),
          ),
        ),
      );
}
