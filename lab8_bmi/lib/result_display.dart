import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final double bmi;
  final String category;

  const ResultDisplay({super.key, required this.bmi, required this.category});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (category) {
      case 'Dưới cân':
        color = Colors.blue;
        break;
      case 'Bình thường':
        color = Colors.green;
        break;
      case 'Thừa cân':
        color = Colors.orange;
        break;
      case 'Béo phì':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Column(
      children: [
        Text(
          bmi > 0 ? bmi.toStringAsFixed(2) : '0.00',
          style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.pink[200]),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          category.isNotEmpty ? category : 'Chưa tính',
          style: TextStyle(
              fontSize: 24, color: color, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          'Phạm vi khỏe mạnh: 18.5 - 24.9',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Container(
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.pink, width: 1),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 185,
                      child: Container(color: Colors.blue.withAlpha(77))),
                  Expanded(
                      flex: 64,
                      child: Container(color: Colors.green.withAlpha(77))),
                  Expanded(
                      flex: 50,
                      child: Container(color: Colors.orange.withAlpha(77))),
                  Expanded(
                      flex: 100,
                      child: Container(color: Colors.red.withAlpha(77))),
                ],
              ),
              if (bmi > 0)
                Positioned(
                  left: (bmi.clamp(0, 40) / 40) *
                      (MediaQuery.of(context).size.width - 80),
                  child: Container(
                    width: 2,
                    height: 20,
                    color: Colors.teal[900],
                  ),
                ),
            ],
          ),
        ),
        /*
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RotatedText('Dưới cân', style: TextStyle(color: Colors.blue)),
            RotatedText('Bình thường', style: TextStyle(color: Colors.green)),
            RotatedText('Thừa cân', style: TextStyle(color: Colors.orange)),
            RotatedText('Béo phì', style: TextStyle(color: Colors.red)),
          ],
        ),
        */
      ],
    );
  }
}

class RotatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const RotatedText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -60 * 3.14159 / 180, // Convert 60 degrees to radians
      child: Text(text, style: style),
    );
  }
}
