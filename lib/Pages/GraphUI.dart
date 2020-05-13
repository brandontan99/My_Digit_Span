import 'dart:collection';

/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mydigitspan/DigitSpanBloc.dart';

/// Sample ordinal data type.
class TestScore {
  final String score;
  final int frequency;

  TestScore(this.score, this.frequency);
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static Future<List<charts.Series<TestScore, String>>>
      createSampleData() async {
    LinkedHashMap<String, int> frequencyData =
        await DigitSpanBloc.frequencyData();
    final data = <TestScore>[];
    frequencyData.forEach((key, value) {
      data.insert(0, TestScore(key, value));
    });
    return [
      new charts.Series<TestScore, String>(
        id: 'Test Score',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TestScore score, _) => score.score,
        measureFn: (TestScore score, _) => score.frequency,
        data: data,
      )
    ];
  }
}

class GraphUI extends StatefulWidget {
  @override
  _GraphUIState createState() => _GraphUIState();
}

class _GraphUIState extends State<GraphUI> {
  List<charts.Series<TestScore, String>> seriesList =
      <charts.Series<TestScore, String>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Score Graph"),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Frequency",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(child: SimpleBarChart(seriesList, animate: true)),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Highest Digits Correct",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _loadData() async {
    seriesList = await SimpleBarChart.createSampleData();
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
  }
}
