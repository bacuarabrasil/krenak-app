import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/CommentList.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/ActivityDetail/TaskList.dart';
import 'package:krenak/Scenes/TaskCreate/TaskCreateView.dart';
import 'package:krenak/Services/Request/MeRequest.dart';

class ActivityDetailViewArguments {
  final Activity activity;

  ActivityDetailViewArguments(this.activity);
}

class ActivityDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActivityDetailViewArguments args = ModalRoute.of(context).settings.arguments as ActivityDetailViewArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Atividade'),
      ),
      body: ListView(children: <Widget>[
        Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      args.activity.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    Text(
                      args.activity.description,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    TaskListWidget(tasks: args.activity.tasks),
                    SizedBox(height: 16),
                    Text(
                      "Comentários",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    CommentListWidget(comments: args.activity.comments),
                    SizedBox(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      // First child is enter comment text input
                      Expanded(
                        child: TextFormField(
                          autocorrect: false,
                          decoration: new InputDecoration(
                            labelText: "Comentar",
                            labelStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            fillColor: Colors.blue,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purpleAccent)),
                          ),
                        ),
                      ),
                      // Second child is button
                      IconButton(
                        icon: Icon(Icons.send),
                        iconSize: 24.0,
                        onPressed: () {},
                      )
                    ]),
                  ],
                ))),
      ]),
      floatingActionButton: Visibility(
        visible: MeRequest.shared.meResponse.role == 'MTR',
        child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/task/create',
            arguments: TaskCreateViewArguments(args.activity.id)
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      )),
    );
  }
}
