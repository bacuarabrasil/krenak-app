import 'package:flutter/material.dart';
import 'package:krenak/Scenes/Homework/Homework.dart';
import 'package:krenak/Scenes/Homework/TaskList.dart';

class HomeworkView extends StatefulWidget {
  @override
  HomeworkViewState createState() {
    return HomeworkViewState();
  }
}

class HomeworkViewState extends State<HomeworkView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // var me = MeRequest().execute();
    // me.then(handleRequest);

    homeworks.add(
      Homework(
        title: 'title',
        description: 'description'
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
              .map((homework) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/homework');
                  },
                  child: Container(
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
                                    color: Colors.white),
                              ),
                              SizedBox(height: 16),
                              Text(
                                homework.description,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 16),
                              TaskListWidget(tasks: [Task(title: "eu", done: false), Task(title: "eu", done: true)])
                            ],
                          )))))
              .toList(),
        ));
  }
}
