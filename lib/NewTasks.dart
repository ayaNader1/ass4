import 'package:ass3/task_model.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';


class NewTasks extends StatefulWidget{
  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  int id ;
  bool isComplete = false ;
  String taskName ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ) ),
              onChanged: (value){
                this.taskName = value ;
              },
            ),
            Checkbox(value: isComplete, onChanged: (value){
              this.isComplete = value ;
              setState(() {});

            },
            ),
            RaisedButton(child: Text('Add New Task') , onPressed: (){
              // tasks.add(Task(this.taskName , this.isComplete));
              DBHelper.dbHelper.insertNewTask(Task(this.taskName , this.isComplete,this.id));
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }
}