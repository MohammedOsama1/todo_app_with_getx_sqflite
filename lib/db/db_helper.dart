import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DBHelper  {
  static Database? database;
  static String? path ;

  static Future crate() async {
// Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = ('${databasesPath}demo.db');
    print(path);

// open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE TS (id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          ' note TEXT, '
          'date TEXT,'
          'repeat TEXT,'
          'startTime TEXT ,'
          'endTime TEXT, '
          'remind INTEGER, '
          'color INTEGER,'
          'isCompleted INTEGER)');
    });
  }
  static Future insert(Task? task) async {
    await database!.transaction((txn) async {
      int note1 = await txn.rawInsert(
          'INSERT INTO TS(title, note, date, repeat, startTime, endTime, remind, color, isCompleted) '
          'VALUES("${task!.title}", "${task.note}","${task.date}", "${task.repeat}","${task.startTime}","${task.endTime}",${task.remind},${task.color},${task.isCompleted})');
      print('inserted1: $note1');
    });
  }
  static  prints() async {
    List<Map> list = await database!.rawQuery('SELECT * FROM TS');
    print(list);
  }
  static delete() async {
    await deleteDatabase('/data/user/0/com.example.todo_app/databasesdemo.db');
    print('delete');

  }
  static update(int id) async {
    await database!.rawUpdate(''' 
     UPDATE TS
       SET isCompleted = ?
       WHERE id = ?
       ''',[1,id]);
  }

static Future<List<Map<String, Object?>>> query () async {

  return await database!.rawQuery('SELECT * FROM TS');
}

static deleteOneTask (int? id) async {
    await database!.delete('TS',where: 'id = ?',whereArgs: [id!]);
}

}

