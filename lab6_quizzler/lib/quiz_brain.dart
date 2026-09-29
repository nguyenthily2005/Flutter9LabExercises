import 'package:lab6_quizzler/question.dart';

class QuizBrain {
  final List<Question> _questionBank = [
    Question('Bananas are berries, but strawberries are not.', true),
    Question('A day on Venus is longer than a year on Venus.', true),
    Question('Humans share about 50% of their DNA with bananas.', true),
    Question('Goldfish only have a 3-second memory.', false),
    Question('Octopuses have three hearts.', true),
    Question('There’s a town in Norway called "Hell."', true),
    Question('Honey never spoils — archaeologists found 3,000-year-old honey that’s still edible.', true),
    Question('You can sneeze with your eyes open.', true),
    Question('The inventor of the frisbee was turned into a frisbee after he died.', true),
    Question('A group of flamingos is called a "flamboyance."', true),
  ];

  int _currentIndex = 0;

  String getQuestionText() => _questionBank[_currentIndex].questionText;
  bool getCorrectAnswer() => _questionBank[_currentIndex].answer;

  void nextQuestion() {
    if (_currentIndex < _questionBank.length - 1) {
      _currentIndex++;
    }
  }

  bool isFinished() => _currentIndex >= _questionBank.length - 1;

  void reset() => _currentIndex = 0;
}
