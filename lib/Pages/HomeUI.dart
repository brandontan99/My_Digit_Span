import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydigitspan/DigitSpanBloc.dart';

import 'DigitSpanUI/DigitSpanUI.dart';
import 'GraphUI.dart';
import 'HighScoreUI.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
        Color.fromRGBO(46, 125, 32, 1),
        Color.fromRGBO(77, 182, 172, 1)
      ]))),
      Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(179, 229, 252, 1),
                Color.fromRGBO(185, 246, 202, 1)
              ]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.45,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Column(
                  children: <Widget>[
                    StartGame(),
                    SizedBox(
                      height: 20,
                    ),
                    _menuButton(
                      "High Score",
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HighScoreUI()));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _menuButton("Graph", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GraphUI()));
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Text(
                "My Digit Span",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ))),
    ]));
  }
}

// Create a Form widget.
class StartGame extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
            onSaved: (String value) {
              DigitSpanBloc.name = value;
            },
            validator: (String value) {
              return (value.isEmpty) ? 'Do not leave it blank' : null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          _menuButton("Start Game", () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DigitSpanUI()));
            }
          }),
        ],
      ),
    );
  }
}

Widget _menuButton(String text, Function onPressed) {
  return RaisedButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Color(0xFF1976D2),
      child: SizedBox(
          width: 150,
          child: Center(
            child: Text(text.toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          )),
      onPressed: onPressed);
}
