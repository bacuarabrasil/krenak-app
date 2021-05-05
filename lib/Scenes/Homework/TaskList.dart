import 'package:flutter/material.dart';
import 'package:krenak/Scenes/Homework/Homework.dart';

class TaskListWidget extends StatefulWidget {
  final List<Task> tasks;

  const TaskListWidget({this.tasks});

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    var tasks = widget.tasks;
    return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: tasks
            .map((task) => ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (task.done) {
                          return Colors.green;
                        }
                        return Colors.grey;
                      },
                    ),
                  ),
                  onPressed: () async {
                    
                  },
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: task.done,
                        onChanged: (bool value) {

                        },
                      ),
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ))
            .toList());
  }
}
