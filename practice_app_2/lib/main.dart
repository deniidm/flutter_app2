import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_number_checker/flutter_number_checker.dart' as checker;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'PracticeApp2'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _numberController = TextEditingController();

  int _inputNumber = 0;
  String _displayedMessage = "";

  void getDisplayedMessage() {
    setState(() {
      String inputString = _numberController.text;
      _inputNumber = int.tryParse(inputString)!;
      if (_isSquare()) {
        _displayedMessage = "Number $_inputNumber is square";
      } else if (_isTriangular()) {
        _displayedMessage = "Number $_inputNumber is triangular";
      } else if (_isSquare() && _isTriangular()) {
        _displayedMessage =
            "Number $_inputNumber is both square and triangular";
      } else {
        _displayedMessage =
            "Number $_inputNumber is neither square nor triangular";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Input number'),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              TextButton(
                  onPressed: () {
                    getDisplayedMessage();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(_displayedMessage),
                          actions: [
                            TextButton(
                              child: const Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Submit number")),
            ],
          ),
        ),
      ),
    );
  }

  bool _isSquare() =>
      checker.FlutterNumberChecker.isPerfectSquare(_inputNumber);

  bool _isTriangular() =>
      checker.FlutterNumberChecker.isPerfectCube(_inputNumber);
}
