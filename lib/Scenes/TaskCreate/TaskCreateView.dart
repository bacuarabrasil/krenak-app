import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

class TaskCreateView extends StatefulWidget {
  @override
  TaskCreateViewState createState() {
    return TaskCreateViewState();
  }
}

class TaskCreateViewState extends State<TaskCreateView> {
  final _formKey = GlobalKey<FormState>();

  Task task = Task();

  @override
  Widget build(BuildContext context) {
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
