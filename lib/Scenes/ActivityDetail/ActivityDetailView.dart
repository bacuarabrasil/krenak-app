import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/CommentList.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/ActivityDetail/TaskList.dart';
import 'package:krenak/Scenes/TaskCreate/TaskCreateView.dart';
import 'package:krenak/Scenes/TaskEdit/TaskEditView.dart';
import 'package:krenak/Services/Request/ActivityRequest.dart';
import 'package:krenak/Services/Request/CommentRequest.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
import 'package:krenak/Services/Request/TaskRequest.dart';

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
    setState(() {
      loading = true;
    });
    var value = ActivityRequest().getActivity(widget.id);
    value.then(handleRequest);
  }

  handleRequest(value) {
    setState(() {
      loading = false;
      activity = value;
    });
  }

  final _formKey = GlobalKey<FormState>();
  var _controller = TextEditingController();

  CommentBody body = CommentBody();
  bool loading = false;

  Activity activity =
      Activity(title: '', description: '', tasks: [], comments: []);

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Atividade'),
      ),
      body: Stack(children: <Widget>[
        ListView(children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        activity.title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      Text(
                        activity.description,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Tarefas",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      TaskListWidget(
                          tasks: activity.tasks,
                          edit: (task) async {
                             await Navigator.pushNamed(context, '/task/edit',
                                  arguments: TaskEditViewArguments(activity.id, task));
                              setState(() {
                                loading = true;
                              });
                              var value = ActivityRequest().getActivity(widget.id);
                              value.then(handleRequest);
                          },
                          delete: (id) async {
                            setState(() {
                              loading = true;
                            });
                            try {
                              await TaskRequest().delete(id);
                            } catch (e) {
                              print(e);
                            }
                            var value =
                                ActivityRequest().getActivity(widget.id);
                            value.then(handleRequest);
                          },
                          callback: (id) {
                            var newTasks = activity.tasks;
                            newTasks[id].done = !newTasks[id].done;
                            handleRequest(Activity(
                                id: activity.id,
                                title: activity.title,
                                description: activity.description,
                                tasks: newTasks,
                                comments: activity.comments));
                            setState(() {
                              loading = true;
                            });
                            var value =
                                ActivityRequest().getActivity(widget.id);
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
                      CommentListWidget(
                        comments: activity.comments,
                        callback: (id) async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            await CommentRequest().delete(id);
                          } catch (e) {

                          }
                          var value =
                              ActivityRequest().getActivity(widget.id);
                          value.then(handleRequest);
                        },
                      ),
                      SizedBox(height: 16),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        // First child is enter comment text input
                        Form(
                          key: _formKey,
                          child: Expanded(
                            child: TextFormField(
                              controller: _controller,
                              autocorrect: false,
                              onSaved: (String value) {
                                body.text = value;
                              },
                              decoration: new InputDecoration(
                                labelText: "Comentar",
                                labelStyle: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                fillColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purpleAccent)),
                              ),
                            ),
                          ),
                        ),
                        // Second child is button
                        IconButton(
                          icon: Icon(Icons.send),
                          iconSize: 24.0,
                          onPressed: () async {
                            _formKey.currentState.save();
                            body.activity = activity.id;
                            _controller.clear();
                            setState(() {
                              loading = true;
                            });
                            try {
                              await CommentRequest().execute(body);
                            } catch (e) {

                            }
                            var value =
                                ActivityRequest().getActivity(widget.id);
                            value.then(handleRequest);
                          },
                        )
                      ]),
                    ],
                  ))),
        ]),
        new Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ]),
      floatingActionButton: Visibility(
          visible: MeRequest.shared.meResponse.role == 'MTR',
          child: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/task/create',
                  arguments: TaskCreateViewArguments(activity.id));
              setState(() {
                loading = true;
              });
              var value = ActivityRequest().getActivity(widget.id);
              value.then(handleRequest);
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          )),
    );
  }
}
