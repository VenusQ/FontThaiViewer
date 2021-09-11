import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  String fonts = 'Prompt';
  int number = 1;

  _handleClickButton1() {
    setState(() {
      fonts = 'Prompt';
      number = 1;
    });
  }

  _handleClickButton2() {
    setState(() {
      fonts = 'Kanit';
      number = 2;
    });
  }

  _handleClickButton3() {
    setState(() {
      fonts = 'Sarabun';
      number = 3;
    });
  }

  _handleClickButton4() {
    setState(() {
      fonts = 'Mitr';
      number = 4;
    });
  }

  _handleClickButton5() {
    setState(() {
      fonts = 'Mali';
      number = 5;
    });
  }

  _showFonts() {
    switch (number) {
      case 1:
        return Text('การเดินทางขากลับคงจะเหงาน่าดู',
          style: GoogleFonts.prompt(fontSize: 60.0),
        );
        break;
      case 2:
        return Text('การเดินทางขากลับคงจะเหงาน่าดู',
          style: GoogleFonts.kanit(fontSize: 60.0),
        );
        break;
      case 3:
        return Text('การเดินทางขากลับคงจะเหงาน่าดู',
          style: GoogleFonts.sarabun(fontSize: 60.0),
        );
        break;
      case 4:
        return Text('การเดินทางขากลับคงจะเหงาน่าดู',
          style: GoogleFonts.mitr(fontSize: 60.0),
        );
        break;
      case 5:
        return Text('การเดินทางขากลับคงจะเหงาน่าดู',
          style: GoogleFonts.mali(fontSize: 60.0),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thai Font Viewer'),
      ),
      backgroundColor: Colors.teal[50],
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _showFonts(),
                    ],
                  ),
                ),
              ),
              Text(
                'Font: $fonts', style: TextStyle(fontSize: 18.0),
              ),

              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      children: [
                        ElevatedButton(onPressed: _handleClickButton1,
                            child: Text('Prompt')),
                        ElevatedButton(onPressed: _handleClickButton2,
                            child: Text('Kanit')),
                        ElevatedButton(onPressed: _handleClickButton3,
                            child: Text('Sarabun')),
                        ElevatedButton(onPressed: _handleClickButton4,
                            child: Text('Mitr')),
                        ElevatedButton(onPressed: _handleClickButton5,
                            child: Text('Mali')),

                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
