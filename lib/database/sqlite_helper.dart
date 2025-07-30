import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  static final SQLiteHelper instance = SQLiteHelper._init();
  static Database? _database;

  SQLiteHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medicines.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        expiryDate TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        time TEXT NOT NULL
      )
    ''');
  }

  // Medicine CRUD
  Future<int> insertMedicine(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('medicines', data);
  }

  Future<List<Map<String, dynamic>>> getAllMedicines() async {
    final db = await instance.database;
    return await db.query('medicines', orderBy: 'expiryDate ASC');
  }

  Future<int> deleteMedicine(int id) async {
    final db = await instance.database;
    return await db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }

  // Reminder CRUD
  Future<int> insertReminder(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('reminders', data);
  }

  Future<List<Map<String, dynamic>>> getAllReminders() async {
    final db = await instance.database;
    return await db.query('reminders', orderBy: 'time ASC');
  }

  Future<int> deleteReminder(int id) async {
    final db = await instance.database;
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}
