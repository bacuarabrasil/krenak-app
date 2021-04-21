import 'package:flutter/material.dart';
import 'package:krenak/Services/Request/MentorshipsRequest.dart';
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
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  // Do nothing
                }
              },
            )
          ],
        ),
        body: ListView(
          children: mentorships
            .map((e) => Text(e.isActive ? "Ativo" : "Não Ativo"))
            .toList(),
        ));
  }
}
