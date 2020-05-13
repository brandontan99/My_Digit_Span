import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DigitSpanBloc.dart';
import '../HighScoreUI.dart';
import 'DisplayScreen.dart';
import 'KeyPad.dart';

class DigitSpanUI extends StatefulWidget {
  @override
  _DigitSpanUIState createState() => _DigitSpanUIState();
}

class _DigitSpanUIState extends State {
  String _output;
  bool _visible = false;
  bool _isButtonDisabled = true;
  StreamSubscription _streamSubscription;
  final textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  void initState() {
    super.initState();
    DigitSpanBloc.initGame();
    _streamSubscription = DigitSpanBloc.displayStream.listen((data) {
      setState(() {
        if (data == "Disable/Enable") {
          _isButtonDisabled = !_isButtonDisabled;
        } else if (data == "You lost!!" || data == "Wrong") {
          _output = data;
          _visible = true;
          if (data == "You lost!!") {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HighScoreUI()));
              });
            });
          }
        } else {
          _output = data;
          _visible = true;
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _visible = false;
            });
          });
        }
      });
    });
    DigitSpanBloc.getRandomNumSeq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Digit Span"),
      ),
      body: Stack(children: <Widget>[
        Container(
          color: Colors.black54,
        ),
        Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            child: Text(
                      "Score: " + DigitSpanBloc.score.toString(),
                      style: textStyle,
                    ))),
                    Expanded(
                      child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: _buildLifeBar()),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "${DigitSpanBloc.times.toString()} DIGITS",
                        style: textStyle,
                      ),
                    ),
                    DisplayScreen(
                      output: _output,
                      visible: _visible,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: KeyPad(
                  isButtonDisabled: _isButtonDisabled,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  List<Widget> _buildLifeBar() {
    List<Widget> icons = <Widget>[];
    icons.add(Text(
      "Life: ",
      style: textStyle,
    ));
    for (int i = 0; i < 3; i++) {
      if (DigitSpanBloc.life > i) {
        icons.add(Icon(
          Icons.favorite,
          color: Colors.red,
        ));
      } else {
        icons.add(Icon(Icons.favorite, color: Colors.transparent));
      }
    }
    return icons;
  }
}
