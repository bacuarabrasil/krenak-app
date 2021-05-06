import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/CommentList.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/ActivityDetail/TaskList.dart';

class ActivityDetailView extends StatefulWidget {
  @override
  ActivityDetailViewState createState() {
    return ActivityDetailViewState();
  }
}

class ActivityDetailViewState extends State<ActivityDetailView> {
  @override
  void initState() {
    super.initState();

    activity = Activity(
        title: 'title',
        description: 'description',
        tasks: [Task(title: "eu", done: false), Task(title: "eu", done: true)],
        comments: [Comment(id: "", name: "Djorkaeff", text: "Texto.")]
    );
  }

  Activity activity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividade'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    activity.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    activity.description,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  TaskListWidget(tasks: activity.tasks),
                  SizedBox(height: 16),
                  Text(
                    "Comentários",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  CommentListWidget(comments: activity.comments)
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
