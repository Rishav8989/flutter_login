// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:intl/intl.dart';
import 'data_point.dart'; // Import the DataPoint class

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = p.join(databasesPath, 'iiot_data.db');

    final bool exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");
      try {
        await Directory(p.dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load("assets/iiot_data.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS iiot_data (
        Timestamp TEXT PRIMARY KEY,
        Power_Consumption_kWh REAL,
        Voltage_V REAL,
        Current_A REAL,
        Power_Factor REAL,
        Grid_Frequency_Hz REAL,
        Reactive_Power_kVAR REAL,
        Active_Power_kW REAL,
        Temperature_C REAL,
        Humidity REAL,
        Solar_Power_Generation_kW REAL,
        Previous_Day_Consumption_kWh REAL,
        Normalized_Consumption REAL
      )
    ''');
  }

  Future<List<DataPoint>> getDataForDate(DateTime date, {int limit = 24}) async {
    final db = await database;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final List<Map<String, dynamic>> maps = await db.query(
      'iiot_data',
      where: 'Timestamp LIKE ?',
      whereArgs: ['$formattedDate%'],
      orderBy: 'Timestamp ASC',
      limit: limit,
    );
    return List.generate(maps.length, (i) {
      return DataPoint.fromMap(maps[i]);
    });
  }

  Future<int> getCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM iiot_data');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}