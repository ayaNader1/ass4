
import 'db_helper.dart';



class Task{
  int id;
  String taskName;
  bool isComplete;
  Task(this.taskName , this.isComplete, [this.id]);
  Task.fromJson(Map map){
    this.id = map[DBHelper.taskIdColumnName];
    this.taskName = map[DBHelper.taskNameColumnName];
    this.isComplete = map[DBHelper.taskIsCompleteColumnName] == 1?true:false;
  }
  toJson() {
    return {
      DBHelper.taskIdColumnName : this.id,
      DBHelper.taskNameColumnName : this.taskName,
      DBHelper.taskIsCompleteColumnName : this.isComplete ? 1 : 0,
    };
  }


}