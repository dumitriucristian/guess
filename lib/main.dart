import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Guess', home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class CustomText extends StatefulWidget {
  const CustomText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: const TextStyle(fontSize: 36));
  }
}

class _MyAppState extends State<MyApp> {
  CustomText _appResponse = const CustomText(text: 'Some text');
  Random random = Random();

  String _buttonText = 'Guess';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //de ce random merge doar aici
    int randomNumber = random.nextInt(100);
    print('randomnumber: $randomNumber');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                "I am thinking about a number between 1 and 100. \n It's your turn to guess my number.",
                style: TextStyle(fontSize: 24),
              ),
              _appResponse,
              Card(
                margin: const EdgeInsets.all(0.5),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Try a number!',
                      style: TextStyle(fontSize: 24),
                    ),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          final int _guessedNr = int.parse(_controller.text);

                          if (randomNumber == _guessedNr) {
                            _buttonText = 'reset';

                            //todo - extract widget showDialog
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('You guessed right'),
                                content: Text('It was $randomNumber'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');
                                      randomNumber = random.nextInt(100);
                                      _appResponse = const CustomText(text: '');
                                      _buttonText = 'Guess';
                                      _controller.clear();
                                      setState(() {});
                                    },
                                    child: const Text('Try again'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');

                                      setState(() {
                                        randomNumber = random.nextInt(100);
                                        _controller.clear();
                                      });
                                    },
                                    child: const Text('ok'),
                                  ),
                                ],
                              ),
                            );
                          } else if (randomNumber > _guessedNr) {
                            _appResponse = CustomText(text: 'You tried $_guessedNr Try higher');
                          } else if (randomNumber < _guessedNr) {
                            _appResponse = CustomText(text: 'You tried $_guessedNr Try lower');
                          } else {
                            _appResponse = const CustomText(text: 'Some stupid exception');
                          }

                          setState(() {
                            _controller.clear();
                          });
                        } catch (s) {
                          if (_controller.text == null) {
                            print('Please provide a number betweeen 0 and 100, not an empty string');
                          }

                          if (num.tryParse(_controller.text) == null) {
                            print('Please provide a number between 0 and 100. Only numbers allowed');
                          }
                        }
                      },
                      child: Text(_buttonText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
