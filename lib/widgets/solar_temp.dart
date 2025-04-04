// lib/monitoring_chart.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

class SensorData {
  final DateTime dateTime;
  final double ambientTemperature;
  final double moduleTemperature;

  SensorData({
    required this.dateTime,
    required this.ambientTemperature,
    required this.moduleTemperature,
  });

  factory SensorData.fromList(List<dynamic> row) {
    try {
      return SensorData(
        dateTime: DateTime.parse(row[0]),
        ambientTemperature: double.tryParse(row[1].toString()) ?? 0.0,
        moduleTemperature: double.tryParse(row[2].toString()) ?? 0.0,
      );
    } catch (e) {
      print('Error creating SensorData: $e');
      rethrow;
    }
  }
}

class SolarTemp extends StatefulWidget {
  final DateTime selectedDate;
  final bool showAmbient;
  final ValueChanged<bool> onShowAmbientChanged;

  const SolarTemp({
    super.key,
    required this.selectedDate,
    required this.showAmbient,
    required this.onShowAmbientChanged,
  });

  @override
  State<SolarTemp> createState() => _SolarTempState();
}

class _SolarTempState extends State<SolarTemp> {
  List<SensorData> sensorData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCsvData();
  }

  @override
  void didUpdateWidget(covariant SolarTemp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      loadCsvData();
    }
  }

  Future<void> loadCsvData() async {
    setState(() => isLoading = true);
    try {
      final csvString = await rootBundle.loadString('assets/solar/sensor.csv');
      final csvTable = const CsvToListConverter().convert(csvString);
      List<SensorData> parsedData = [];
      for (int i = 1; i < csvTable.length; i++) {
        final row = csvTable[i];
        if (row.length == 4) {
          try {
            parsedData.add(SensorData.fromList(row));
          } catch (e) {
            print('Error parsing data in row $i: $e');
          }
        } else {
          print('Warning: Row $i has ${row.length} columns, skipping.');
        }
      }
      setState(() {
        sensorData = parsedData;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading CSV: $e');
      setState(() => isLoading = false);
    }
  }

  List<SensorData> getFilteredData() {
    return sensorData.where((data) {
      return data.dateTime.year == widget.selectedDate.year &&
          data.dateTime.month == widget.selectedDate.month &&
          data.dateTime.day == widget.selectedDate.day;
    }).toList();
  }

  SensorData _findSensorDataByX(int x, List<SensorData> data) {
    if (data.isEmpty) {
      return SensorData(
        dateTime: DateTime.now(),
        ambientTemperature: 0,
        moduleTemperature: 0,
      );
    }
    SensorData closest = data.first;
    int closestDiff = (closest.dateTime.millisecondsSinceEpoch - x).abs();
    for (var entry in data) {
      int diff = (entry.dateTime.millisecondsSinceEpoch - x).abs();
      if (diff < closestDiff) {
        closest = entry;
        closestDiff = diff;
      }
    }
    return closest;
  }

  Widget buildChart(List<SensorData> data) {
    List<LineChartBarData> lineBars = [];
    List<String> lineDataTypes = [];

    if (widget.showAmbient) {
      lineBars.add(LineChartBarData(
        spots: data
            .map((d) => FlSpot(
                  d.dateTime.millisecondsSinceEpoch.toDouble(),
                  d.ambientTemperature,
                ))
            .toList(),
        isCurved: true,
        color: Colors.blue,
        barWidth: 2,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.blue.withOpacity(0.05),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        dotData: FlDotData(show: false), // Remove dots on the line
      ));
      lineDataTypes.add('Ambient Temperature');
    }

    // Module temperature is always shown
    lineBars.add(LineChartBarData(
      spots: data
          .map((d) => FlSpot(
                d.dateTime.millisecondsSinceEpoch.toDouble(),
                d.moduleTemperature,
              ))
          .toList(),
      isCurved: true,
      color: const Color.fromARGB(255, 255, 154, 72),
      barWidth: 2,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 255, 154, 72).withOpacity(0.3),
            Color.fromARGB(255, 255, 154, 72).withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      dotData: FlDotData(show: false), // Remove dots on the line
    ));
    lineDataTypes.add('Module Temperature');

    // Calculate the start and end of the day
    DateTime startOfDay =
        DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day);
    DateTime endOfDay = DateTime(
        widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day, 23, 59, 59);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineBarsData: lineBars,
                titlesData: FlTitlesData(
                  // Removed Module Temperature from top titles
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // Added hourly markings on x-axis
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        // Calculate 2-hourly intervals
                        DateTime time =
                            DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        if (time.isAfter(startOfDay) &&
                            time.isBefore(endOfDay) &&
                            time.hour % 1 == 0) {
                          return Text(
                            time.hour.toString().padLeft(1, '0'),
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        // Show y-axis titles every 10 degrees starting from 0
                        if (value.toInt() % 10 == 0) {
                          return Text(
                            '${value.toInt()}°C',
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true, // Enable grid lines
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),


                borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey[800]!, width: 1)),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final dataType = lineDataTypes[spot.barIndex];
                        final x = spot.x.toInt();
                        final sensorData = _findSensorDataByX(x, data);
                        double value;
                        switch (dataType) {
                          case 'Ambient Temperature':
                            value = sensorData.ambientTemperature;
                            break;
                          case 'Module Temperature':
                            value = sensorData.moduleTemperature;
                            break;
                          default:
                            value = 0.0;
                        }
                        DateTime dateTime =
                            DateTime.fromMillisecondsSinceEpoch(x);
                        return LineTooltipItem(
                          '$dataType: ${value.toStringAsFixed(1)}°C at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SensorData> filteredData = getFilteredData();

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              buildChart(filteredData),
              const SizedBox(height: 20),
              // Toggle for Ambient Temperature with padding
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ambient Temperature',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: widget.showAmbient,
                      onChanged: widget.onShowAmbientChanged,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}