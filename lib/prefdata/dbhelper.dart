import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static const String _dbName = 'app.db';
  static const String _table = 'app_data';

  static const String colKey = 'key';
  static const String colValue = 'value';

  /// Get database instance
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        $colKey TEXT PRIMARY KEY,
        $colValue TEXT
      )
    ''');
  }

  /// Save data
  static Future<void> set(String key, String value) async {
    final db = await database;
    await db.insert(
      _table,
      {colKey: key, colValue: value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Read data
  static Future<String?> get(String key) async {
    final db = await database;
    final result = await db.query(
      _table,
      where: '$colKey = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first[colValue] as String;
    }
    return null;
  }

  /// Remove data
  static Future<void> remove(String key) async {
    final db = await database;
    await db.delete(
      _table,
      where: '$colKey = ?',
      whereArgs: [key],
    );
  }

  /// Clear all
  static Future<void> clear() async {
    final db = await database;
    await db.delete(_table);
  }
}
