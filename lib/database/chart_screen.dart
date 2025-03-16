// chart_screen.dart
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'data_point.dart';
import 'chart_widgets.dart'; // Import the chart widgets

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<DataPoint> _data = [];
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();
  DateTime _selectedDate = DateTime(2025, 1, 1);

  @override
  void initState() {
    super.initState();
    _loadData(date: _selectedDate);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData({DateTime? date}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<DataPoint> newData;
      if (date != null) {
        newData = await DatabaseHelper.instance.getDataForDate(date);
      } else {
        newData = await DatabaseHelper.instance
            .getDataForDate(DateTime(2025, 1, 1));
      }
      setState(() {
        _data = newData;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data: $e")),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Energy Data Charts',
                style: TextStyle(color: Theme.of(context).colorScheme.primary))),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Energy Data Charts',
                style: TextStyle(color: Theme.of(context).colorScheme.primary))),
        body: const Center(child: Text("No data in database.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Energy Data Charts',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary.withOpacity(0.3),
        actions: [
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                });
                _loadData(date: _selectedDate);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            ChartSection(
              title: "System Performance Metrics",
              charts: [
                SingleChart(
                    data: _data,
                    title: "Power Consumption (kWh)",
                    getValue: (d) => d.powerConsumption,
                    color: Colors.blue,
                    description:
                        "Shows the amount of electrical energy consumed by the system or household over a period, crucial for monitoring usage patterns and energy management."),
                SingleChart(
                    data: _data,
                    title: "Solar Power Generation (kW)",
                    getValue: (d) => d.solarPowerGeneration,
                    color: Colors.pink,
                    description:
                        "Reflects the power output of the solar panels at a specific time, directly related to sunlight intensity and panel efficiency."),
                SingleChart(
                    data: _data,
                    title: "Normalized Consumption",
                    getValue: (d) => d.normalizedConsumption,
                    color: Colors.lime,
                    description:
                        "Provides a standardized measure of consumption, often adjusted for variables like temperature or occupancy, useful for comparing energy usage across different conditions."),
              ],
            ),
            ChartSection(
              title: "Electrical Parameters",
              charts: [
                SingleChart(
                    data: _data,
                    title: "Voltage (V)",
                    getValue: (d) => d.voltage,
                    color: Colors.red,
                    description:
                        "Measures the electrical potential difference in the system, important for ensuring proper operation of electrical components and identifying potential issues."),
                SingleChart(
                    data: _data,
                    title: "Current (A)",
                    getValue: (d) => d.current,
                    color: Colors.green,
                    description:
                        "Indicates the flow of electrical charge, helping determine power flow and identify any overloads or inefficiencies."),
                SingleChart(
                    data: _data,
                    title: "Power Factor",
                    getValue: (d) => d.powerFactor,
                    color: Colors.orange,
                    description:
                        "Represents the ratio of real power to apparent power in an AC system, showing how effectively the system uses electrical power and affecting overall efficiency."),
                SingleChart(
                    data: _data,
                    title: "Grid Frequency (Hz)",
                    getValue: (d) => d.gridFrequency,
                    color: Colors.purple,
                    description:
                        "Shows the frequency of the alternating current in the grid, essential for synchronization and stable operation of electrical devices."),
                SingleChart(
                    data: _data,
                    title: "Reactive Power (kVAR)",
                    getValue: (d) => d.reactivePower,
                    color: Colors.yellow,
                    description:
                        "Measures the portion of electrical power that creates magnetic fields or provides insulation, important for understanding the overall electrical load characteristics."),
                SingleChart(
                    data: _data,
                    title: "Active Power (kW)",
                    getValue: (d) => d.activePower,
                    color: Colors.cyan,
                    description:
                        "Represents the actual power consumed or produced by the system, directly related to performing work and running appliances."),
              ],
            ),
            ChartSection(
              title: "Environmental Factors",
              charts: [
                SingleChart(
                    data: _data,
                    title: "Temperature (°C)",
                    getValue: (d) => d.temperature,
                    color: Colors.amber,
                    description:
                        "Affects solar panel efficiency and battery performance, with higher temperatures potentially reducing panel output."),
                SingleChart(
                    data: _data,
                    title: "Humidity",
                    getValue: (d) => d.humidity,
                    color: Colors.teal,
                    description:
                        "Can impact some components of the system and may correlate with cloud cover, which affects solar generation."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}