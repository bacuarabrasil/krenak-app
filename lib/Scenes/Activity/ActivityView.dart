import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

class ActivityView extends StatefulWidget {
  @override
  ActivityViewState createState() {
    return ActivityViewState();
  }
}

class ActivityViewState extends State<ActivityView> {

  @override
  void initState() {
    super.initState();
    // var me = MeRequest().execute();
    // me.then(handleRequest);

    activities.add(
      Activity(
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

  List<Activity> activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Atividades'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: activities
              .map((activity) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/activity/detail');
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
                            ],
                          )))))
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/activity/create');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
        );
  }
}
