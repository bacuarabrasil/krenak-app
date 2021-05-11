import 'package:flutter/material.dart';
import 'package:krenak/Scenes/Activity/ActivityView.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
import 'package:krenak/Services/Request/MentorshipsRequest.dart';
import 'package:krenak/Services/Response/MeResponse.dart';
import 'package:krenak/Services/Response/MentorshipsResponse.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    var mentorships = MentorshipsRequest().execute();
    mentorships.then(handleRequest);
  }

  handleRequest(value) {
    setState(() {
      mentorships = value.results;
    });
  }

  List<Mentorship> mentorships = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Krenak'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                try {
                  await AuthStore.shared.logout();
                } catch (e) {
                  // Do nothing
                }
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: mentorships
              .map((mentorship) => InkWell(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityView(id: mentorship.id),
                    )
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
                              Visibility(
                                visible: mentorship.menteeEnrollment.enrollee.id != MeRequest.shared.meResponse.id,
                                child: Text(
                                mentorship.menteeEnrollment.enrollee.firstName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                ),
                              ),
                              Visibility(
                                visible: mentorship.mentorEnrollment.enrollee.id != MeRequest.shared.meResponse.id,
                                child: Text(
                                mentorship.mentorEnrollment.enrollee.firstName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 16),
                              Visibility(
                                visible: mentorship.mentorEnrollment.enrollee.id != MeRequest.shared.meResponse.id,
                                child: Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children:
                                      mentorship.mentorEnrollment.interests
                                          .map((e) => Chip(
                                              backgroundColor: Colors.green,
                                              label: Text(e.description,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ))))
                                          .toList())),
                              Visibility(
                                visible: mentorship.menteeEnrollment.enrollee.id != MeRequest.shared.meResponse.id,
                                child: Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children:
                                      mentorship.menteeEnrollment.interests
                                          .map((e) => Chip(
                                              backgroundColor: Colors.green,
                                              label: Text(e.description,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ))))
                                          .toList()))
                            ],
                          )))))
              .toList(),
        ));
  }
}
