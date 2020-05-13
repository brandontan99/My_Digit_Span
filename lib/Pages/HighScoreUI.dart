import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mydigitspan/DigitSpanBloc.dart';

class HighScoreUI extends StatefulWidget {
  @override
  _HighScoreUIState createState() => _HighScoreUIState();
}

class _HighScoreUIState extends State<HighScoreUI> {
  LinkedHashMap<String, int> listOfHighScore;
  List<String> names;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("High Score"),
        ),
        body: Center(
          child: ListView.separated(
            itemBuilder: (context, position) {
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(names[position]),
                trailing: Text(listOfHighScore[names[position]].toString()),
              );
            },
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemCount: listOfHighScore != null ? listOfHighScore.length : 0,
          ),
        ));
  }

  Future<void> _loadData() async {
    LinkedHashMap<String, int> tempList = await DigitSpanBloc.getAllHighScore();
    if (tempList != null) {
      setState(() {
        listOfHighScore = tempList;
        names = listOfHighScore.keys.toList();
      });
    }
  }
}
