import 'package:crud_app_sqlite/src/models/task_model.dart';
import 'package:crud_app_sqlite/src/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeController {
  final listValue = ValueNotifier<List<TaskModel>>([]);
  HomeController() {
    _loadTasks();
  }
  late Database db;
  Future<void> _loadTasks() async {
    listValue.value = await DB.instance.getAllTasks();
  }

  Future<void> addTask(TaskModel task) async {
    await DB.instance.addTask(task);
    _loadTasks(); 
  }

  Future<void> updateTasks(TaskModel task) async {
    await DB.instance.updateTask(task);
    _loadTasks(); 
  }

  Future<void> deleteTask(int id) async {
    await DB.instance.deleteTask(id);
    _loadTasks();
  }
}
