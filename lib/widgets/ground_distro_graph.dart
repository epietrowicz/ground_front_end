import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GroundDistroGraph extends StatelessWidget {
  const GroundDistroGraph({this.x, this.y, this.gradient});

  final List<double> x;
  final List<double> y;
  final List<Color> gradient;
  LineChartData graphData() {
    double xMax = x.reduce(max);
    double yMax = y.reduce(max);
    List<FlSpot> barGraphFromGrindSizes = [];

    int i = 0;
    for (double val in x) {
      barGraphFromGrindSizes.add(FlSpot(val, y[i]));
      i++;
    }
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          interval: (xMax / 4),
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 15),
          getTitles: (value) {
            double quarter = xMax / 4;
            double half = xMax / 2;
            double threeQuarter = quarter + half;
            if (value == 0.0) {
              return '0';
            } else if (value == quarter) {
              return value.toStringAsFixed(1);
            } else if (value == half) {
              return value.toStringAsFixed(1);
            } else if (value == threeQuarter) {
              return value.toStringAsFixed(1);
            } else if (value == xMax) {
              return value.toStringAsFixed(1);
            } else {
              return '';
            }
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: (yMax / 4),
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          reservedSize: 15,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: xMax,
      minY: 0,
      maxY: yMax.toDouble(),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          preventCurveOverShooting: true,
          spots: barGraphFromGrindSizes,
          colors: gradient,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradient.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AspectRatio(
        aspectRatio: 1.1,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
              graphData(),
            ),
          ),
        ),
      ),
    );
  }
}
