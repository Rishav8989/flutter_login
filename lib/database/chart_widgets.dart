// chart_widgets.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'data_point.dart'; // Import DataPoint
import 'dart:math';

class ChartSection extends StatelessWidget {
  final String title;
  final List<Widget> charts;

  const ChartSection({super.key, required this.title, required this.charts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        ...charts,
      ],
    );
  }
}

class SingleChart extends StatelessWidget {
  final String title;
  final double Function(DataPoint) getValue;
  final Color color;
  final String description;
  final List<DataPoint> data; // Pass data directly
  final double? maxWidth; // Add a maxWidth parameter

  const SingleChart({
    super.key,
    required this.title,
    required this.getValue,
    required this.color,
    required this.description,
    required this.data,
    this.maxWidth, // Optional maxWidth
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Wrap SizedBox with ConstrainedBox and Align
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? double.infinity, // Use provided maxWidth or infinity
              ),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 250,
                  child: LineChart(_buildChartData(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildChartData(BuildContext context) {
      final spots = _getSpots(data, getValue);

    if (data.isEmpty) {
      return LineChartData();
    }

    final minX = data.first.timestamp.millisecondsSinceEpoch.toDouble();
    final maxX = data.last.timestamp.millisecondsSinceEpoch.toDouble();

    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var spot in spots) {
      minY = min(minY, spot.y);
      maxY = max(maxY, spot.y);
    }
    final double yRange = maxY - minY;
    final double horizontalInterval = yRange == 0 ? 1.0 : yRange / 5;

     minY -= (maxY-minY) * 0.1;
     maxY += (maxY-minY) * 0.1;
     if(minY == maxY){
       minY = minY - 0.1;
       maxY = maxY + 0.1;
     }

    final twoHoursInMillis = 2 * 60 * 60 * 1000;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: horizontalInterval,
        verticalInterval: twoHoursInMillis.toDouble(),
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: twoHoursInMillis.toDouble(),
            getTitlesWidget: (value, meta) {
              final dt = DateTime.fromMillisecondsSinceEpoch(value.toInt());
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  DateFormat('HH:mm').format(dt),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 45,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(1),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              );
            },
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: color.withOpacity(0.2),
          ),
        ),
      ],
      lineTouchData: LineTouchData( // Simplified tooltip
        touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot barSpot) {
                return LineTooltipItem(
                  barSpot.y.toStringAsFixed(2), // Just the value
                  TextStyle(
                    color: barSpot.bar.color,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
        handleBuiltInTouches: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.grey,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 6,
                  color: Colors.blueAccent,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }

    List<FlSpot> _getSpots(
      List<DataPoint> data, double Function(DataPoint) getValue) {
    return data
        .map((point) => FlSpot(
            point.timestamp.millisecondsSinceEpoch.toDouble(), getValue(point)))
        .toList();
  }
}