import 'package:flutter/material.dart';
import 'package:mydigitspan/DigitSpanBloc.dart';

class Key extends StatelessWidget {
  final value;
  final isButtonDisabled;

  Key({this.value, this.isButtonDisabled});

  void _keyPressed() {
    DigitSpanBloc.nextRound(value);
  }

  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: Colors.blueGrey,
        elevation: 4,
        child: Visibility(
            visible: value != null,
            child: Text(
              value.toString(),
              style: textStyle,
            )),
        onPressed: (isButtonDisabled) ? null : () => _keyPressed(),
      )),
    );
  }
}

class KeyPad extends StatelessWidget {
  final isButtonDisabled;

  const KeyPad({this.isButtonDisabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Key(
              value: "9",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "8",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "7",
              isButtonDisabled: isButtonDisabled,
            ),
          ],
        )),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Key(
              value: "6",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "5",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "4",
              isButtonDisabled: isButtonDisabled,
            ),
          ],
        )),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Key(
              value: "3",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "2",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "1",
              isButtonDisabled: isButtonDisabled,
            ),
          ],
        )),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Key(
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              value: "0",
              isButtonDisabled: isButtonDisabled,
            ),
            Key(
              isButtonDisabled: isButtonDisabled,
            ),
          ],
        ))
      ],
    );
  }
}
