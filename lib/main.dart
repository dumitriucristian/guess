import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    title: 'Guess',
    home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class CustomText extends StatelessWidget {
  const CustomText({Key key, this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("$text", style: TextStyle(fontSize: 36));
  }
}


class _MyAppState extends State<MyApp> {

  //de ce state are efect doar cu variabilele declarate  aici ?
  CustomText _appResponse = CustomText(text:'Some text');
  static Random  _random = new Random();
  static int _randomNumber = _random.nextInt(100);

  int _guessedNr = 0;
  String _buttonText = "Guess";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //de ce random merge doar aici

    print('randomnumber: $_randomNumber');

    return Scaffold(
      appBar: AppBar(
        title: Text('Guess my number'),
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("I am thinking about a number between 1 and 100. \n It's your turn to guess my number.",
                  style: TextStyle(fontSize: 24),
              ),
              _appResponse,
              Card(
                margin: EdgeInsets.all(0.5),
                elevation: 5,
                child: Column(
                  children: [

                    Text(
                      "Try a number!",
                      style: TextStyle(fontSize: 24),
                    ),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          try{
                            int _guessedNr = int.parse(_controller.text);

                            if( _randomNumber == _guessedNr) {
                                _buttonText = "reset";

                                //todo - extract widget showDialog
                                showDialog(context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Text('You guessed right'),
                                      content: Text('It was $_randomNumber'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                            _randomNumber = _random.nextInt(100);
                                            _appResponse = CustomText(text:'');
                                            _buttonText = "Guess";
                                            _controller.clear();
                                            setState(() {
                                           });
                                          },
                                          child: Text('Try again'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                              Navigator.pop(context, 'Cancel');
                                              _randomNumber = _random.nextInt(100);
                                              setState(() {
                                                _randomNumber;
                                                _controller.clear();
                                              }
                                            );
                                          },
                                              child: Text('ok'),
                                          ),
                                        ],
                                    ),
                                );

                            }else if(_randomNumber > _guessedNr) {
                              _appResponse = CustomText(text:'You tried $_guessedNr Try higher');
                            }else if(_randomNumber < _guessedNr) {
                              _appResponse = CustomText(text:'You tried $_guessedNr Try lower');
                            }else{
                              _appResponse = CustomText(text:'Some stupid exception');
                            }

                            setState(() {
                              _appResponse ;
                              _buttonText;
                              _controller.clear();
                            });

                          } catch(s, e) {
                           print(numberValidator(_controller.text));
                        }
                      },
                        child: Text("$_buttonText"),
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

   String numberValidator(String value) {

     if(value == null) {
       return "Please provide a number betweeen 0 and 100, not an empty string";
     }

     final n = num.tryParse(value);
     if(n == null) {
       return "Please provide a number between 0 and 100. Only numbers allowed";
     }
     return null;
   }
}
