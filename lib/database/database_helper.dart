import 'package:address_book/database/db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String dbName = 'address.db';
  String tbName = 'book';
  final COLUMN_ID = 'id';
  final COLUMN_Name = 'name';
  final COLUMN_Phone = 'phone';
  final COLUMN_Email = 'email';
  final COLUMN_Address = 'address';
  static DatabaseHelper? databaseHelper;
  DatabaseHelper._create();
  Database? _database;
  factory DatabaseHelper() {
    databaseHelper ??= DatabaseHelper._create();
    return databaseHelper!;
  }
  Future<Database> getDatabase() async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var directory = await getDatabasesPath();
    var db = join(directory, dbName);
    return openDatabase(db, version: 1, onCreate: _create);
  }

  Future<void> _create(Database database, version) async {
    String sql =
        'CREATE TABLE $tbName($COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT'
        ',$COLUMN_Name CHAR,$COLUMN_Phone CHAR,$COLUMN_Email CHAR,$COLUMN_Address CHAR)';
    database.execute(sql);
  }

  Future<List<BookDatabase>> getData() async {
    Database db = await getDatabase();

    var newsMap = await db.query(tbName);
    List<BookDatabase> footballList =
        newsMap.map((e) => BookDatabase.fromMap(e)).toList();
    return footballList;
  }

  Future<int> save(BookDatabase book) async {
    Database db = await getDatabase();
    return db.insert(tbName, book.toMap());
  }

  deleteSave(int id) async {
    Database db = await delSaveData(id);
    return db.delete(tbName, where: 'id=?', whereArgs: [id]);
  }

  Future<Database> delSaveData(int? id) async {
    return _database!;
  }
}
