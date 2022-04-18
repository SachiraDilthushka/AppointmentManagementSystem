import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'bar_chart_model1.dart';

final List<BarChartModel> data = [
  BarChartModel(
    year: "2014",
    financial: 250,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "2015",
    financial: 300,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "2016",
    financial: 100,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "2017",
    financial: 450,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "2018",
    financial: 630,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "2019",
    financial: 950,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "2020",
    financial: 400,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
];
