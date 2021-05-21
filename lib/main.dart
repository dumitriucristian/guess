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



class _MyAppState extends State<MyApp> {

  //get a random nr between 1 .. 100
  //input try the number
  //if lower.. try higher
  //if higher.. try lower
  //if equla.. got it


  @override
  Widget build(BuildContext context) {
    Random _random= new Random();
    int _randomNumber = _random.nextInt(100);
    int _guessedNr = 0;
    TextEditingController _controller = TextEditingController();
    String _appResponse = "";


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
                  style: TextStyle(fontSize: 16),
              ),
              Card(
                margin: EdgeInsets.all(0.5),
                elevation: 5,
                child: Column(
                  children: [
                    Text("Try a number!", style: TextStyle(fontSize: 24),),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          try{
                            int _guessedNr = int.parse(_controller.text);

                            if( _randomNumber == _guessedNr) {
                              print('ok');
                            }else if(_randomNumber > _guessedNr) {
                              print('go higher');
                            }else if(_randomNumber < _guessedNr) {
                              print('go lower');
                            }else{
                              print('Some stupid exceptional case');
                            }

                            setState(() {
                              _appResponse = "You tried $_guessedNr ";
                              print("ssss$_appResponse");
                            });

                          } catch(s, e) {
                           print(numberValidator(_controller.text));
                        }
                    },
                        child: Text("Guess"))
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
