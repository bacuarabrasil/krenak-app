import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

class ActivityCreateView extends StatefulWidget {
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Descrição'),
                    onSaved: (String value) {
                      activity.description = value;
                    },
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
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
