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
  bool loading = false;

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
        appBar: AppBar(title: Text('Criar Atividade')),
        body: Stack(children: <Widget>[
          Container(
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
                          setState(() {
                            loading = true;
                          });
                          try {
                            await ActivityRequest().execute(ActivityBody(
                                title: activity.title,
                                description: activity.description,
                                mentorship: widget.id));
                          } catch (e) {
                            // Do nothing
                          }
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Criar'),
                      ),
                    ),
                  ],
                ),
              )),
              new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ]));
  }
}
