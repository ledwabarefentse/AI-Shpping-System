import 'dart:async';
import 'dart:math';
// ignore: unnecessary_import
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class AccuracyChart extends StatefulWidget {
  State<StatefulWidget> createState() => AccuracyChartState();
}

class AccuracyChartState extends State<AccuracyChart> {
  List<AccuracyData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfCartesianChart(
        title: ChartTitle(
            text: 'AI Models Accuracy Results',
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        series: <ChartSeries>[
          ColumnSeries<AccuracyData, String>(
              dataSource: _chartData,
              xValueMapper: (AccuracyData acc, _) => acc.model,
              yValueMapper: (AccuracyData acc, _) => acc.accuracy,
              pointColorMapper: (AccuracyData data, _) => data.color,
              dataLabelSettings: DataLabelSettings(isVisible: true)),
        ],
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(text: 'Accuracy in %')),
      ),
    );
  }

  List<AccuracyData> getChartData() {
    final List<AccuracyData> chartData = [
      AccuracyData(96.45, 'Decision Tree Training', Colors.black54),
      AccuracyData(64.14, 'Naive Bayes Training', Colors.purpleAccent),
      AccuracyData(94.32, 'Decision Tree Testing', Colors.black54),
      AccuracyData(64.06, 'Naive Bayes Testing', Colors.purpleAccent)
    ];
    return chartData;
  }
}

class AccuracyData {
  final String model;
  final double accuracy;
  final Color color;

  AccuracyData(this.accuracy, this.model, this.color);
}
