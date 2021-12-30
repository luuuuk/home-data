import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../theme.dart';

class GraphCardWidget extends StatelessWidget {
  const GraphCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
      child: DataLineChart(),
    );
  }
}

// ignore: must_be_immutable
class DataLineChart extends StatelessWidget {
  final spots = List.generate(101, (i) => (i - 50) / 10)
      .map((x) => FlSpot(x, sin(x)))
      .toList();

  DataLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          minY: -1.5,
          maxY: 1.5,
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
            horizontalInterval: 2.0,
            verticalInterval: 12.0,
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
