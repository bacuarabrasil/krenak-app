import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Services/Request/TaskRequest.dart';

class TaskCreateView extends StatefulWidget {
  @override
  TaskCreateViewState createState() {
    return TaskCreateViewState();
  }
}

class TaskCreateViewArguments {
  final String id;

  TaskCreateViewArguments(this.id);
}

class TaskCreateViewState extends State<TaskCreateView> {
  final _formKey = GlobalKey<FormState>();

  Task task = Task();

  @override
  Widget build(BuildContext context) {
    final TaskCreateViewArguments args = ModalRoute.of(context).settings.arguments as TaskCreateViewArguments;
    return Scaffold(
        appBar: AppBar(title: Text('Criar Tarefa')),
        body: Container(
            margin: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Título'),
                    onSaved: (String value) {
                      task.title = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        try {
                          await TaskRequest().execute(
                            TaskBody(
                              title: task.title,
                              activity: args.id
                            )
                          );
                        } catch (e) {

                        }
                        Navigator.pop(context);
                      },
                      child: Text('Criar'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
