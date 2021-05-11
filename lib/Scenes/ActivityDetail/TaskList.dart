import 'dart:core';
import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Services/Request/TaskRequest.dart';

class TaskListWidget extends StatefulWidget {
  final List<Task> tasks;
  final Function(int) callback;

  const TaskListWidget({this.tasks, this.callback});

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
            .mapIndexed((task, index) => ElevatedButton(
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
                    try {
                      await TaskRequest().executePath(TaskPatch(id: task.id, done: !task.done));
                    } catch (e) {

                    }
                    widget.callback(index);
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

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
