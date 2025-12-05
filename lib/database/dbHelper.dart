import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Dbhelper._();

  static final Dbhelper Instance = Dbhelper._();

  Database? myDB;
  static const String DATABASE_NAME = 'mydatabase.db';
  static const String TABLE_NAME = 'todo';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_isDone = 'isDone';

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      return await createDb();
    }
  }

  Future<Database> createDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DATABASE_NAME);

    /// change later
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE_NAME(
        $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_TITLE TEXT,
        $COLUMN_isDone INTEGER DEFAULT 0
        )
        ''');
      },
    );
  }

  /// insert data into database
  Future<bool> insertDB({required String title}) async {
    final db = await getDB();
    int RowsEffected = await db.insert(TABLE_NAME, {COLUMN_TITLE: title});
    return RowsEffected > 0;
  }

  /// read all data from database
  Future<List<Map<String, Object?>>> fetchDB() async {
    final db = await getDB();
    var fetchedData = await db.query(TABLE_NAME);
    return fetchedData;
  }

  /// update data in database
  Future<bool> updateDB({required int id, required String title}) async {
    final db = await getDB();
    int RowsEffected = await db.update(
      TABLE_NAME,
      {COLUMN_TITLE: title},
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
    return RowsEffected > 0;
  }

  /// delete data from database
  Future<bool> deleteDB({required int id}) async {
    final db = await getDB();
    int RowsEffected = await db.delete(
      TABLE_NAME,
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
    return RowsEffected > 0;
  }

  /// isDone status updater in database
  Future<bool> updateIsDone({required int id, required bool isDone}) async {
    final db = await getDB();
    int RowsEffected = await db.update(
      TABLE_NAME,
      {COLUMN_isDone: isDone ? 1 : 0},
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
    return RowsEffected > 0;
  }
}
