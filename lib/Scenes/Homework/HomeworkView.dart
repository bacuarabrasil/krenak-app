import 'package:flutter/material.dart';
import 'package:krenak/Scenes/Homework/CommentList.dart';
import 'package:krenak/Scenes/Homework/Homework.dart';
import 'package:krenak/Scenes/Homework/TaskList.dart';

class HomeworkView extends StatefulWidget {
  @override
  HomeworkViewState createState() {
    return HomeworkViewState();
  }
}

class HomeworkViewState extends State<HomeworkView> {

  @override
  void initState() {
    super.initState();
    // var me = MeRequest().execute();
    // me.then(handleRequest);

    homeworks.add(
      Homework(
        title: 'title',
        description: 'description',
        tasks: [Task(title: "eu", done: false), Task(title: "eu", done: true)],
        comments: [Comment(id: "", name: "Djorkaeff", text: "Texto.")]
      )
    );
  }

  handleRequest(value) {
    // var profile = Profile(
    //     email: value.email,
    //     firstName: value.firstName,
    //     lastName: value.lastName,
    //     birthdate: value.birthdate);
    // _emailController.text = profile.email;
    // _firstNameController.text = profile.firstName;
    // _lastNameController.text = profile.lastName;
    // _birthdateController.text = profile.birthdate;
    // setState(() {
    //   profile = profile;
    // });
  }

  List<Homework> homeworks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Atividades'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: homeworks
              .map((homework) => Container(
                      decoration: new BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: new BorderRadius.circular(8.0)),
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                homework.title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 16),
                              Text(
                                homework.description,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 16),
                              TaskListWidget(tasks: homework.tasks),
                              SizedBox(height: 16),
                              Text(
                                "Comentários",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 16),
                              CommentListWidget(comments: homework.comments)
                            ],
                          ))))
              .toList(),
        ),
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
