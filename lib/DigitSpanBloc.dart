import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class DigitSpanBloc {
  static final _displayStreamController = StreamController<String>.broadcast();
  static List<String> numSeqDisplayed = <String>[];
  static int _index = 0, _times = 3, _max = 10, _score = 0;
  static bool _isButtonDisabled = false;
  static int _life = 3;
  static String name;

  static StreamSink<String> get displaySink => _displayStreamController.sink;

  static Stream<String> get displayStream => _displayStreamController.stream;

  static int get score => _score;

  static int get times => _times;

  static int get life => _life;

  static bool get isButtonDisabled => _isButtonDisabled;

  static void initGame() {
    _index = 0;
    _times = 3;
    _score = 0;
    _life = 3;
    _isButtonDisabled = false;
    numSeqDisplayed.clear();
  }

  static Future<void> setDisplayValue(String num) async {
    displaySink.add(num);
    await Future.delayed(Duration(seconds: 1));
  }

  static void decreaseLife() {
    _life--;
  }

  static Future<void> printCountdown() async {
    for (int i = 3; i > 0; i--) {
      await setDisplayValue(i.toString());
      if (i == 1) {
        await setDisplayValue("START!");
      }
    }
  }

  static void getRandomNumSeq() async {
    Random rand = Random();
    _index = 0;
    await printCountdown();
    for (int i = 0; i < _times; i++) {
      int randNum = rand.nextInt(_max);
      String strRandNum = randNum.toString();
      print(i.toString() + " " + randNum.toString());
      numSeqDisplayed.add(strRandNum);
      await setDisplayValue(strRandNum);
    }
    print("Finished generating number");
    setDisplayValue("Disable/Enable"); //enable the button
  }

  static bool isCorrect(String num) {
    return numSeqDisplayed[_index] == num;
  }

  static void nextRound(String num) async {
    await setDisplayValue(num);
    if (isCorrect(num)) {
      _index++;
      if (_index == numSeqDisplayed.length) {
        await setDisplayValue("CORRECT!");
        if (_score == 0) {
          _score = 3;
        } else {
          _score++;
        }
        _times++;
        numSeqDisplayed.clear();
        setDisplayValue("Disable/Enable"); //disable the button
        getRandomNumSeq();
      }
    } else {
      decreaseLife();
      await setDisplayValue("Wrong");
    }
    if (_life == 0) {
      addToHighScore(name);
      setDisplayValue("You lost!!");
    }
  }

  static void addToHighScore(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_score != 0) {
      prefs.setInt(name, _score);
    }
  }

  static Future<LinkedHashMap<String, int>> getAllHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LinkedHashMap<String, int> highScores =
        new LinkedHashMap<String, int>.fromIterable(prefs.getKeys(),
            key: (k) => k, value: (k) => prefs.getInt(k));
    var sortedKeys = prefs.getKeys().toList(growable: false)
      ..sort((k1, k2) => highScores[k2].compareTo(highScores[k1]));
    LinkedHashMap<String, int> sortedListOfHighScore =
        new LinkedHashMap<String, int>.fromIterable(sortedKeys,
            key: (k) => k, value: (k) => highScores[k]);
    return sortedListOfHighScore;
  }

  static Future<LinkedHashMap<String, int>> frequencyData() async {
    LinkedHashMap<String, int> highScores = await getAllHighScore();
    var values = highScores.values.toList();
    highScores.clear();
    values.forEach((element) {
      if (!highScores.containsKey(element.toString())) {
        highScores[element.toString()] = 1;
      } else {
        highScores[element.toString()]++;
      }
    });
    return highScores;
  }

  static dispose() {
    _displayStreamController.close();
  }
}
