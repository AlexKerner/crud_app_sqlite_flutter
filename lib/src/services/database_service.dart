import 'dart:io';
import 'package:crud_app_sqlite/src/models/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();
  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         content TEXT,
         status INTEGER
      )
    ''');
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    var result = await db.query('tasks', orderBy: 'id');
    return result.isNotEmpty
        ? result.map((map) => TaskModel.fromMap(map)).toList()
        : [];
  }

  Future<int> addTask(TaskModel task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update('tasks', task.toMap(), where: 'id = ${task.id}', whereArgs: []);
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = $id', whereArgs: []);
  }
}
