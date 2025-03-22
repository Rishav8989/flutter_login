import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/date_picker.dart';
import 'package:login/widgets/detailed_chart.dart';
import 'package:login/widgets/solar_temp.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  DateTime selectedDate = DateTime.now();
  bool showAmbient = true;

  @override
  void initState() {
    super.initState();
    if (DateTime.now().isAfter(DateTime(2024, 6, 17))) {
      selectedDate = DateTime(2024, 6, 17);
    } else {
      selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date picker widget
                DatePickerWidget(
                  selectedDate: selectedDate,
                  onDateSelected: (newDate) {
                    setState(() => selectedDate = newDate);
                  },
                ),
                // Add Module Temperature heading below date picker
                const SizedBox(height: 10),
                const Text(
                  'Module Temperature',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SolarTemp(
                  selectedDate: selectedDate,
                  showAmbient: showAmbient,
                  onShowAmbientChanged: (value) {
                    setState(() {
                      showAmbient = value;
                    });
                  },
                ),
                // Add a button to open the Detailed Chart
                ElevatedButton(
                  onPressed: () {
                    // Navigate to DetailedChart using GetX
                    Get.to(
                      () => DetailedChart(),
                      transition: Transition.cupertino,
                    );
                  },
                  child: const Text('Detailed Chart'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}