import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/stress_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'stress_management.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE manajemen_stres (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stress_factor TEXT,
        coping_strategy TEXT,
        stress_level INTEGER
      )
    ''');
  }

  Future<int> insertStress(StressModel stress) async {
    Database db = await database;
    return await db.insert('manajemen_stres', stress.toMap());
  }

  Future<List<StressModel>> getStresses() async {
    Database db = await database;
    List<Map> maps = await db.query('manajemen_stres');
    return List.generate(maps.length, (i) {
      return StressModel(
        id: maps[i]['id'],
        stressFactor: maps[i]['stress_factor'],
        copingStrategy: maps[i]['coping_strategy'],
        stressLevel: maps[i]['stress_level'],
      );
    });
  }

  Future<int> updateStress(StressModel stress) async {
    Database db = await database;
    return await db.update(
      'manajemen_stres',
      stress.toMap(),
      where: 'id = ?',
      whereArgs: [stress.id],
    );
  }

  Future<int> deleteStress(int id) async {
    Database db = await database;
    return await db.delete(
      'manajemen_stres',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}