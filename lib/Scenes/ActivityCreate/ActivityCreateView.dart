import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Services/Request/ActivityRequest.dart';

class ActivityCreateView extends StatefulWidget {
  final String id;

  ActivityCreateView({Key key, @required this.id}) : super(key: key);

  @override
  ActivityCreateViewState createState() {
    return ActivityCreateViewState();
  }
}

class ActivityCreateViewState extends State<ActivityCreateView> {
  final _formKey = GlobalKey<FormState>();

  Activity activity = Activity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Criar Atividade')),
        body: Container(
            margin: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Título'),
                    onSaved: (String value) {
                      activity.title = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Descrição'),
                    onSaved: (String value) {
                      activity.description = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        ActivityRequest().execute(ActivityBody(
                          title: activity.title,
                          description: activity.description,
                          mentorship: widget.id
                        ));
                        Navigator.pop(context);
                      },
                      child: Text('Criar'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
