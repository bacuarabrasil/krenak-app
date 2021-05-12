import 'dart:core';
import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
import 'package:krenak/Services/Request/TaskRequest.dart';

class TaskListWidget extends StatefulWidget {
  final List<Task> tasks;
  final Function(int) callback;
  final Function(String) delete;

  const TaskListWidget({this.tasks, this.callback, this.delete});

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  _showBottomSheet(String id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.edit),
                    title: new Text('Editar'),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text('Deletar'),
                  onTap: () async {
                    Navigator.pop(context);
                    widget.delete(id);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Cancelar'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var tasks = widget.tasks;
    return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: tasks
            .mapIndexed((task, index) => ElevatedButton(
              onLongPress: () {
                if (MeRequest.shared.meResponse.role == 'MTR') {
                  _showBottomSheet(task.id);
                }
              },
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
