import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}
class Game {
  final int _answer;
  int _totalGuesses;
  List _numberGuesses;

  Game() : _answer = Random().nextInt(100) + 1, _totalGuesses = 0, _numberGuesses = [] {
    print("The answer is: $_answer");
  }

  int get totalGuesses {
    return _totalGuesses;
  }

  int get answer {
    return _answer;
  }

  List get numberGuesses {
    return _numberGuesses;
  }

  int doGuess(int num) {
    _totalGuesses++;
    _numberGuesses.add(num);
    if(num > _answer) {
      return 1;
    } else if(num < _answer) {
      return -1;
    } else {
      return 0;
    }
  }

}

class _GamePageState extends State<GamePage> {
  late Game _game;
  final _controller = TextEditingController();
  String? _guessNumber;
  String? _feedback;
  bool end = false;
  bool restart = false;

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
      ),
      body: Container(
        color: Colors.yellow[100],
        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo_number.png'),
            fit: BoxFit.fill
          ),
        ),*/
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildInputPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_number.png',
          width: 300.0, // 160 = 1 inch
        ),
        Text(
          'GUESS THE NUMBER',
          style: GoogleFonts.kanit(fontSize: 30.0, color: Colors.teal),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    if (_guessNumber == null) {
      return Container(
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "I'm thinking of a number between 1 and 100.",
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Can you guess it? ",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center),
                  Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            _guessNumber!,
            style: TextStyle(fontSize: 80),
          ),
          !end ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.disabled_by_default_outlined,
                    size: 40,
                    color: Colors.red,
                  ),
                  Text(
                    _feedback!,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ],
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done_outlined,
                size: 40,
                color: Colors.green,
              ),
              Text(
                _feedback!,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          end
              ? TextButton(
              onPressed:
                  () {
                end = false;
                _guessNumber = null;
                _game.numberGuesses.clear();
                _game = Game();

              },
              child: Text('NEW GAME'))
              : SizedBox.shrink()
        ],
      );
    }
  }

  Widget _buildInputPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.yellow,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  isDense: true,
                  // กำหนดลักษณะเส้น border ของ TextField ในสถานะปกติ
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  // กำหนดลักษณะเส้น border ของ TextField เมื่อได้รับโฟกัส
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Enter the number here',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  int totalGuesses = _game.totalGuesses + 1;
                  int answer = _game.answer;
                  List numberGuesses = _game.numberGuesses;
                  String numberGuessesToString = '';
                  _guessNumber = _controller.text;
                  int? guess = int.tryParse(_guessNumber!);
                  if (guess != null) {
                    var result = _game.doGuess(guess);

                    switch (result) {
                      case 1:
                        _feedback = 'TOO HIGH!';
                        break;
                      case -1:
                        _feedback = 'TOO LOW!';
                        break;
                      case 0:
                        _feedback = 'CORRECT!';
                        end = true;

                        for(var i=0;i<numberGuesses.length-1;i++){
                          numberGuessesToString += numberGuesses[i].toString() + ' -> ';
                        }
                        numberGuessesToString += numberGuesses[numberGuesses.length-1].toString();
                        _showMaterialDialog('GOOD JOB!', 'The answer is $answer.\n'
                            'You have made $totalGuesses guesses.\n'
                            +numberGuessesToString
                        );
                        break;
                    }
                  } else {

                    if(!end)
                      _guessNumber = null;
                    _showMaterialDialog("Error", 'Please enter the number');
                  }

                  _controller.clear();
                });
              },
              child: Text(
                'GUESS',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}