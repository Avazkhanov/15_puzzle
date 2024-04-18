import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init();
      return _database!;
    }
  }

  Future<Database> _init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'score.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS GameData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        moves INTEGER,
        timer INTEGER
      )
    ''');
  }

  Future<void> saveGameData(int moves, int timer) async {
    final Database db = await database;
    await db.transaction((txn) async {
      await txn.insert('GameData', {
        'moves': moves,
        'timer': timer,
      });
    });
  }

  Future<List<Map<String, dynamic>>> getAllGameData() async {
    final Database db = await database;
    return await db.query('GameData');
  }
}