import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../theme.dart';

class GraphCardWidget extends StatelessWidget {
  const GraphCardWidget(
    this.dataPoints,
    this.dataIndex, {
    Key? key,
  }) : super(key: key);

  final List dataPoints;
  final int dataIndex;

  @override
  Widget build(BuildContext context) {
    String dataKey;
    switch (dataIndex) {
      case 0:
        dataKey = 'temperature';
        break;
      case 1:
        dataKey = 'humidity';
        break;
      case 2:
        dataKey = 'pressure';
        break;
      case 3:
        dataKey = 'gas';
        break;
      default:
        dataKey = 'temperature';
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DataLineChart(dataPoints, dataKey),
    );
  }
}

// ignore: must_be_immutable
class DataLineChart extends StatelessWidget {
  final List dataPoints;
  final String dataKey;

  const DataLineChart(this.dataPoints, this.dataKey, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxY = 0.0;
    double minY = 1300;
    double horzInterval;
    final spots = dataPoints.asMap().entries.map((e) {
      if (e.value[dataKey].toDouble() < minY) {
        minY = e.value[dataKey].toDouble();
      }
      if (e.value[dataKey].toDouble() > maxY) {
        maxY = e.value[dataKey].toDouble();
      }
      return FlSpot(e.key.toDouble(), e.value[dataKey].toDouble());
    }).toList();
    horzInterval = (maxY - minY) / 2;
    return SizedBox(
      width: 400,
      height: 400,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                maxContentWidth: 100,
                tooltipBgColor: ThemeColors.accentYellow,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final textStyle = GoogleFonts.quicksand(
                      color: ThemeColors.lightWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    return LineTooltipItem(
                        '${touchedSpot.x}, ${touchedSpot.y.toStringAsFixed(2)}',
                        textStyle);
                  }).toList();
                }),
            handleBuiltInTouches: true,
            getTouchLineStart: (data, index) => 0,
          ),
          lineBarsData: [
            LineChartBarData(
              colors: [
                ThemeColors.accentYellow,
              ],
              spots: spots,
              isCurved: true,
              isStrokeCapRound: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          minY: minY,
          maxY: maxY,
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
                showTitles: false,
                getTextStyles: (context, value) => const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                margin: 16,
                reservedSize: 40),
            rightTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            horizontalInterval: horzInterval,
            verticalInterval: 36.0,
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
