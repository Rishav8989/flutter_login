// data_point.dart
class DataPoint {
  final DateTime timestamp;
  final double powerConsumption;
  final double voltage;
  final double current;
  final double powerFactor;
  final double gridFrequency;
  final double reactivePower;
  final double activePower;
  final double temperature;
  final double humidity;
  final double solarPowerGeneration;
  final double previousDayConsumption;
  final double normalizedConsumption;

  DataPoint({
    required this.timestamp,
    required this.powerConsumption,
    required this.voltage,
    required this.current,
    required this.powerFactor,
    required this.gridFrequency,
    required this.reactivePower,
    required this.activePower,
    required this.temperature,
    required this.humidity,
    required this.solarPowerGeneration,
    required this.previousDayConsumption,
    required this.normalizedConsumption,
  });

  factory DataPoint.fromMap(Map<String, dynamic> map) {
    return DataPoint(
      timestamp: DateTime.parse(map['Timestamp']),
      powerConsumption: (map['Power_Consumption_kWh'] as num?)?.toDouble() ?? 0.0,
      voltage: (map['Voltage_V'] as num?)?.toDouble() ?? 0.0,
      current: (map['Current_A'] as num?)?.toDouble() ?? 0.0,
      powerFactor: (map['Power_Factor'] as num?)?.toDouble() ?? 0.0,
      gridFrequency: (map['Grid_Frequency_Hz'] as num?)?.toDouble() ?? 0.0,
      reactivePower: (map['Reactive_Power_kVAR'] as num?)?.toDouble() ?? 0.0,
      activePower: (map['Active_Power_kW'] as num?)?.toDouble() ?? 0.0,
      temperature: (map['Temperature_C'] as num?)?.toDouble() ?? 0.0,
      humidity: (map['Humidity'] as num?)?.toDouble() ?? 0.0,
      solarPowerGeneration:
          (map['Solar_Power_Generation_kW'] as num?)?.toDouble() ?? 0.0,
      previousDayConsumption:
          (map['Previous_Day_Consumption_kWh'] as num?)?.toDouble() ?? 0.0,
      normalizedConsumption:
          (map['Normalized_Consumption'] as num?)?.toDouble() ?? 0.0,
    );
  }
}