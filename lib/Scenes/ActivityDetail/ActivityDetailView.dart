import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/CommentList.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/ActivityDetail/TaskList.dart';
import 'package:krenak/Scenes/TaskCreate/TaskCreateView.dart';
import 'package:krenak/Services/Request/ActivityRequest.dart';
import 'package:krenak/Services/Request/MeRequest.dart';

class ActivityDetailViewArguments {
  final Activity activity;

  ActivityDetailViewArguments(this.activity);
}

class ActivityDetail extends StatefulWidget {
  final String id;

  ActivityDetail({Key key, @required this.id}) : super(key: key);

  @override
  ActivityDetailView createState() => new ActivityDetailView();
}

class ActivityDetailView extends State<ActivityDetail> {

  @override
  void initState() {
    super.initState();
    var value = ActivityRequest().getActivity(widget.id);
    value.then(handleRequest);
  }

  handleRequest(value) {
    setState(() {
      activity = value;
    });
  }

  Activity activity = Activity(title: '', description: '', tasks: [], comments: []);

  @override
  Widget build(BuildContext context) {
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
                    TaskListWidget(tasks: activity.tasks, callback: (id) {
                      var newTasks = activity.tasks;
                      newTasks[id].done = !newTasks[id].done;
                      handleRequest(Activity(
                        id: activity.id,
                        title: activity.title,
                        description: activity.description,
                        tasks: newTasks,
                        comments: activity.comments
                      ));
                      var value = ActivityRequest().getActivity(widget.id);
                      value.then(handleRequest);
                    }),
                    SizedBox(height: 16),
                    Text(
                      "Comentários",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    CommentListWidget(comments: activity.comments),
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
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            '/task/create',
            arguments: TaskCreateViewArguments(activity.id)
          );
          var value = ActivityRequest().getActivity(widget.id);
          value.then(handleRequest);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      )),
    );
  }
}