import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/ActivityDetail/ActivityDetailView.dart';
import 'package:krenak/Services/Request/MeRequest.dart';

class ActivityViewArguments {
  final List<Activity> activities;

  ActivityViewArguments(this.activities);
}

class ActivityView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ActivityViewArguments args = ModalRoute.of(context).settings.arguments as ActivityViewArguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Atividades'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: args.activities
              .map((activity) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/activity/detail',
                    arguments: ActivityDetailViewArguments(activity)
                  );
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
        floatingActionButton: Visibility(
          visible: MeRequest.shared.meResponse.role == 'MTR',
          child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/activity/create');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      )),
        );
  }
}
