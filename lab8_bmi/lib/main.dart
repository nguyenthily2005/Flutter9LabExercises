import 'package:flutter/material.dart';
import 'header.dart';
import 'input_form.dart';
import 'result_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.teal[50],
        cardColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.pink[200], fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[200],
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double _bmi = 0.0;
  String _category = '';
  bool _isValid = true;

  void _calculateBMI(double height, double weight) {
    if (height <= 0 || weight <= 0) {
      setState(() {
        _isValid = false;
      });
      return;
    }
    setState(() {
      _isValid = true;
      _bmi = weight / ((height / 100) * (height / 100));
      if (_bmi < 18.5) {
        _category = 'Dưới cân';
      } else if (_bmi < 25) {
        _category = 'Bình thường';
      } else if (_bmi < 30) {
        _category = 'Thừa cân';
      } else {
        _category = 'Béo phì';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: Colors.pink[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InputForm(onCalculate: _calculateBMI),
                ),
              ),
              SizedBox(height: 20),
              if (!_isValid)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Vui lòng nhập giá trị hợp lệ cho chiều cao và cân nặng.',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(height: 10),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ResultDisplay(bmi: _bmi, category: _category),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
