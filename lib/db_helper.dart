import 'package:ass3/task_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper extends ChangeNotifier{

  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDB.db' ;
  static final String tableName = 'tasks' ;
  static final String taskIdColumnName = 'id' ;
  static final String taskNameColumnName = 'name' ;
  static final String taskIsCompleteColumnName = 'isComplete' ;
  Database database ;
  Future<Database>initDatabase() async{
    if(database == null){
      return await createDatabase();
    }else{
      return database;
    }
  }
  Future<Database> createDatabase() async{
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      // String path = databasesPath + '/tasksDB.db' ; // as last line
      Database database = await openDatabase(path , version: 1 , onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
        $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT ,
        $taskNameColumnName TEXT NOT NULL ,
        $taskIsCompleteColumnName INTEGER 
        )''');
      },);
      return database;
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }
  insertNewTask(Task task) async{
    try {
      database = await initDatabase();
      int x = await database.insert(tableName, task.toJson());
      print(x);
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }
  Future<List<Task>> selectAllTasks() async{
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      List<Task> tasks = result.map((e) => Task.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }
  Future<List<Task>> selectSpecificTask(int isComplete) async{
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName , where: '$taskIsCompleteColumnName=?' , whereArgs: [isComplete]);
      List<Task> tasks = result.map((e) => Task.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }
  updateTask(Task task)async{
    try {
      database = await initDatabase();
      int result = await database.update(tableName , task.toJson() , where: '$taskIdColumnName=?' , whereArgs: [task.id]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }
  deleteTask(Task task)async{
    try {
      database = await initDatabase();
      int result = await database.delete(tableName , where: '$taskIdColumnName=?' , whereArgs: [task.id]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }


}