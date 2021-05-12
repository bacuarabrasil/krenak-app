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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = loading
        ? new Container(
            color: Colors.grey[300],
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();
    final TaskCreateViewArguments args =
        ModalRoute.of(context).settings.arguments as TaskCreateViewArguments;
    return Scaffold(
        appBar: AppBar(title: Text('Criar Tarefa')),
        body: Stack(children: <Widget>[
          Container(
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
                          setState(() {
                            loading = true;
                          });
                          try {
                            await TaskRequest().execute(
                                TaskBody(title: task.title, activity: args.id));
                            setState(() {
                              loading = false;
                            });
                          } catch (e) {}
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Criar'),
                      ),
                    ),
                  ],
                ),
              )),
          new Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          )
        ]));
  }
}
