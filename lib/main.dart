import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operator = '';
  bool _isOperatorSelected = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_isOperatorSelected) {
        _input = number;
        _isOperatorSelected = false;
      } else {
        _input += number;
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_num1 == 0.0) {
        _num1 = double.parse(_input);
        _operator = operator;
        _isOperatorSelected = true;
      } else {
        _num2 = double.parse(_input);
        _calculateResult();
        _operator = operator;
        _isOperatorSelected = true;
      }
    });
  }

  void _onEqualPressed() {
    setState(() {
      if (_num1 != 0.0 && _num2 == 0.0) {
        _num2 = double.parse(_input);
        _calculateResult();
        _isOperatorSelected = true;
      }
    });
  }

  void _calculateResult() {
    switch (_operator) {
      case '+':
        _input = (_num1 + _num2).toString();
        break;
      case '-':
        _input = (_num1 - _num2).toString();
        break;
      case '*':
        _input = (_num1 * _num2).toString();
        break;
      case '/':
        if (_num2 != 0) {
          _input = (_num1 / _num2).toString();
        } else {
          _input = 'Error';
        }
        break;
    }
    _num1 = double.parse(_input);
  }

  void _onClearPressed() {
    setState(() {
      _input = '';
      _num1 = 0.0;
      _num2 = 0.0;
      _operator = '';
      _isOperatorSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _input,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildOperatorButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildOperatorButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton('0'),
              _buildOperatorButton('+'),
              _buildEqualButton(),
              _buildClearButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () => _onNumberPressed(label),
      child: Text(label),
    );
  }

  Widget _buildOperatorButton(String operator) {
    return ElevatedButton(
      onPressed: () => _onOperatorPressed(operator),
      child: Text(operator),
    );
  }

  Widget _buildEqualButton() {
    return ElevatedButton(
      onPressed: _onEqualPressed,
      child: Text('='),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: _onClearPressed,
      child: Text('C'),
    );
  }
}
