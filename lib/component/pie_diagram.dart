import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

enum LegendShape { Circle, Rectangle }

class TaskStatPie extends StatelessWidget {

  final Map<String, double> _dataMap;
  final double _ringStrokeWidth;
  final double _chartLegendSpacing;
  final List<Color> _colorList;
  final List<List<Color>>? _gradientList;
  final String _title;

  TaskStatPie({required Map<String, double> dataMap, required String title, double ringStrokeWidth = 5, double chartLegendSpacing = 32,
    List<Color> colorList = const [
      Color(0xfffdcb6e),
      Color(0xff0984e3),
      Color(0xfffd79a8),
      Color(0xffe17055),
      Color(0xff6c5ce7),
      ],
    List<List<Color>>? gradientList
  }):
    this._dataMap = dataMap,
    this._title = title,
    this._ringStrokeWidth = ringStrokeWidth,
    this._chartLegendSpacing = chartLegendSpacing,
    this._colorList = colorList,
    this._gradientList = gradientList;


  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  final emptyColorGradientList = [
    Color(0xff6c5ce7),
    Colors.blue,
  ];

  ChartType? _chartType = ChartType.ring;
  bool _showCenterText = true;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = false;
  bool _showChartValues = false;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.right;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: _dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 50),
      colorList: _colorList.skip(1).toList(),
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? _title : null,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
      emptyColor: _colorList[0],
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: emptyColorGradientList,
    );
  }
}