import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'bar_chart_model2.dart';
import 'bar_chart_data2.dart';
import 'bar_chart_model1.dart';
import 'bar_Chart_data1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return  Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 2,
                right: 10,
                top: 2,
                bottom: 2,
              ),
              child: Text(
                "Dash board",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 180,
              // padding: const EdgeInsets.all(20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: charts.BarChart(
                          series,
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              "session progress",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF0D47A1),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Weekly progress",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF0D47A1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                StackedColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y1),
                                StackedColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y2),
                                StackedColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y3),
                                StackedColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y4)
                              ])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
