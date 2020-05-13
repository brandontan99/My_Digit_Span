import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  final output;
  final visible;

  DisplayScreen({this.output, this.visible});

  final textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 150,
    color: Color.fromRGBO(0, 100, 0, 1),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 200,
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
            padding: EdgeInsets.all(20),
            color: Colors.white12,
            child: Center(
                child: AnimatedOpacity(
                    opacity: visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 100),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        output.toString(),
                        style: textStyle,
                      ),
                    )))),
      ),
    );
  }
}
