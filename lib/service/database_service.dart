import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../app/modules/explore/models/local_car_model.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  final String DATABASE_NAME = 'car_rental_app_db';
  final int DATABASE_VERSION = 1;

  final String CAR_TABLE = 'car_table';
  final String ID = 'id';
  final String CAR_DATA = 'car';

  Future<Database> _initiateDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, DATABASE_NAME);

    var createdDatabase = await openDatabase(path,
        version: DATABASE_VERSION, onCreate: _onCreate);
    return createdDatabase;
  }

  Future<void> _onCreate(Database db, int version) async {
    String weatherTable =
        "CREATE TABLE $CAR_TABLE($ID INTEGER PRIMARY KEY, $CAR_DATA TEXT)";
    await db.execute(weatherTable);
  }

  Future<List<LocalCar>> getAllCars() async {
    var dbClient = await database;
    String sql = "SELECT * FROM $CAR_TABLE";
    List<Map<String, dynamic>> results = await dbClient.rawQuery(sql);
    return results.map((row) => LocalCar.fromMap(row)).toList();
  }

  Future<LocalCar> getCarById(int id) async {
    var dbClient = await database;
    String sql = "SELECT * FROM $CAR_TABLE WHERE $ID = $id";
    final result = await dbClient.rawQuery(sql);
    return LocalCar.fromMap(result.first);
  }

  Future<int> addCar(LocalCar carData) async {
    var dbClient = await database;
    final data = carData.toMap();
    int result = await dbClient.insert(CAR_TABLE, data);
    debugPrint('Add Data=> $result');
    return result;
  }

  Future<void> updateCar(int id, LocalCar carData) async {
    var dbClient = await database;
    var car = carData.toJson();
    String sql = "UPDATE $CAR_TABLE SET $CAR_DATA = '$car' WHERE $ID = $id";
    await dbClient.rawQuery(sql);
  }

  Future<int> deleteCar(int id) async {
    var dbClient = await database;
    var result = dbClient.delete(CAR_TABLE, where: "$ID = ? ", whereArgs: [id]);
    return result;
  }

  Future<int> getCarCountById(int id) async {
    var dbClient = await database;
    String sql = "SELECT COUNT(*) FROM $CAR_TABLE WHERE $ID = $id";
    var result = await dbClient.rawQuery(sql);
    int? count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}
