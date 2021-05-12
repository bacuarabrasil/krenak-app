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

    setState(() {
      _loading = true;
    });
    var mentorships = MentorshipsRequest().execute();
    mentorships.then(handleRequest);
  }

  handleRequest(value) {
    setState(() {
      mentorships = value.results;
      _loading = false;
    });
  }

  List<Mentorship> mentorships = [];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _loading
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
        appBar: AppBar(
          title: Text('Krenak'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/profile');
                var mentorships = MentorshipsRequest().execute();
                mentorships.then(handleRequest);
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
        body: new Stack(children: <Widget>[
          ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: mentorships
                .map((mentorship) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ActivityView(id: mentorship.id),
                          ));
                    },
                    child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: new BorderRadius.circular(8.0)),
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Visibility(
                                  visible:
                                      mentorship.menteeEnrollment.enrollee?.id !=
                                          MeRequest.shared.meResponse.id,
                                  child: Text(
                                    mentorship
                                        .menteeEnrollment.enrollee.firstName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      mentorship.mentorEnrollment.enrollee?.id !=
                                          MeRequest.shared.meResponse.id,
                                  child: Text(
                                    mentorship
                                        .mentorEnrollment.enrollee.firstName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Visibility(
                                    visible: mentorship
                                            .mentorEnrollment.enrollee.id !=
                                        MeRequest.shared.meResponse.id,
                                    child: Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        children: mentorship
                                            .mentorEnrollment.interests
                                            .map((e) => Chip(
                                                backgroundColor: Colors.green,
                                                label: Text(e.description,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ))))
                                            .toList())),
                                Visibility(
                                    visible: mentorship
                                            .menteeEnrollment.enrollee.id !=
                                        MeRequest.shared.meResponse.id,
                                    child: Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        children: mentorship
                                            .menteeEnrollment.interests
                                            .map((e) => Chip(
                                                backgroundColor: Colors.green,
                                                label: Text(e.description,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ))))
                                            .toList()))
                              ],
                            )))))
                .toList(),
          ),
          new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ]));
  }
}
