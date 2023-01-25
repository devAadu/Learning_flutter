import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  late TooltipBehavior _toolTipBehaviour ;
  late TrackballBehavior _trackballBehavior;

  List<_SalesData> data = [
    _SalesData(2017, 35),
    _SalesData(2018, 28),
    _SalesData(2019, 34),
    _SalesData(2020, 32),
    _SalesData(2021, 40),
    _SalesData(2022, 66),
    _SalesData(2023, 50),
    _SalesData(2024, 70),
    _SalesData(2025, 80),
    _SalesData(2026, 90),
  ];

  List<double> data1 = [
    35,
    28,
    34,
    32,
    40,
    66,
    50,
    70,
    80,
    90,
  ];




  @override
  initState(){
    super.initState();
    _toolTipBehaviour = TooltipBehavior(enable: true,
        color: Colors.blue,
        header: "",
        format: 'point.y%'
    );

    _trackballBehavior = TrackballBehavior(
      // Enables the trackball
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(
            enable: true,
            color: Colors.red
        )
    );


  }


  final LinearGradient _myGradient  =  LinearGradient(colors: [Colors.blue[400]!,Colors.blue[300]!,Colors.blue[100]!.withOpacity(0.1)],stops: const [
    0.0,0.2,1.0
  ],begin:const Alignment(0,-1),end: const Alignment(0,0) );


  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots =
    data1.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    return Column(
      children: [
        SfCartesianChart(
          tooltipBehavior: _toolTipBehaviour,
          trackballBehavior: _trackballBehavior,
          primaryXAxis: CategoryAxis(

          ),
          series: <ChartSeries>[
            SplineAreaSeries<_SalesData, double>(
              borderColor: Colors.blue,
              dataSource: data,
              borderWidth: 2,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              dataLabelSettings: const DataLabelSettings(isVisible: true ),
              enableTooltip: true,
              gradient: _myGradient,
              animationDuration: 1000,

            )

          ],
        ),
        Expanded(child: LineChart(

          LineChartData(
            minX: 0,
            maxX: spots.length.toDouble(),
            minY: 0,
            maxY: 100,

            lineBarsData: [
              LineChartBarData(
                isCurved: true,
              color: Colors.blue,
              belowBarData: BarAreaData(
                show: true,
               gradient: _myGradient
              ),
              spots:spots,

              )

            ]
          )

        )
        )
      ],
    );
  }
}


class _SalesData {
  _SalesData(this.year, this.sales);

  final double year;
  final double sales;
}

