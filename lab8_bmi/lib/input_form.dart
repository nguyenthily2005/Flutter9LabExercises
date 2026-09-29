import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final Function(double, double) onCalculate;

  const InputForm({super.key, required this.onCalculate});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  double _age = 30;
  double _weight = 70.0;
  double _height = 170.0;
  String _gender = 'Male';

  final TextEditingController _ageController =
      TextEditingController(text: '30');
  final TextEditingController _weightController =
      TextEditingController(text: '70.0');
  final TextEditingController _heightController =
      TextEditingController(text: '170.0');

  @override
  void initState() {
    super.initState();
    _ageController.addListener(() {
      double value = double.tryParse(_ageController.text) ?? _age;
      if (value < 0 || value > 120) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tuổi phải từ 0 đến 120')),
        );
      } else {
        setState(() {
          _age = value;
        });
      }
    });
    _weightController.addListener(() {
      double value = double.tryParse(_weightController.text) ?? _weight;
      if (value < 30 || value > 150) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cân nặng phải từ 30 đến 150 kg')),
        );
      } else {
        setState(() {
          _weight = value;
        });
      }
    });
    _heightController.addListener(() {
      double value = double.tryParse(_heightController.text) ?? _height;
      if (value < 100 || value > 220) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chiều cao phải từ 100 đến 220 cm')),
        );
      } else {
        setState(() {
          _height = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tuổi:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Colors.teal),
              onPressed: () {
                setState(() {
                  if (_age > 0) {
                    _age--;
                    _ageController.text = _age.toStringAsFixed(0);
                  }
                });
              },
            ),
            Expanded(
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.teal),
              onPressed: () {
                setState(() {
                  if (_age < 120) {
                    _age++;
                    _ageController.text = _age.toStringAsFixed(0);
                  }
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        Slider(
          value: _age,
          min: 0,
          max: 120,
          divisions: 120,
          activeColor: Colors.teal,
          onChanged: (value) {
            setState(() {
              _age = value;
              _ageController.text = value.toStringAsFixed(0);
            });
          },
        ),
        SizedBox(height: 20),
        Text('Cân nặng (kg):',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: _weightController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        SizedBox(width: 10),
        Slider(
          value: _weight,
          min: 30,
          max: 150,
          divisions: 1200,
          activeColor: Colors.teal,
          onChanged: (value) {
            setState(() {
              _weight = value;
              _weightController.text = value.toStringAsFixed(1);
            });
          },
        ),
        SizedBox(height: 20),
        Text('Chiều cao (cm):',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: _heightController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        SizedBox(width: 10),
        Slider(
          value: _height,
          min: 100,
          max: 220,
          divisions: 1200,
          activeColor: Colors.teal,
          onChanged: (value) {
            setState(() {
              _height = value;
              _heightController.text = value.toStringAsFixed(1);
            });
          },
        ),
        SizedBox(height: 20),
        Text('Giới tính:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          selectedColor: Colors.teal,
          fillColor: Colors.teal[100],
          isSelected: [_gender == 'Male', _gender == 'Female'],
          onPressed: (index) {
            setState(() {
              _gender = index == 0 ? 'Male' : 'Female';
            });
          },
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Icon(Icons.male, size: 30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Icon(Icons.female, size: 30),
            ),
          ],
        ),
        SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: () {
              double height = double.tryParse(_heightController.text) ?? 0;
              double weight = double.tryParse(_weightController.text) ?? 0;
              if (height >= 100 &&
                  height <= 220 &&
                  weight >= 30 &&
                  weight <= 150) {
                widget.onCalculate(height, weight);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vui lòng nhập giá trị hợp lệ')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Tính toán', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
