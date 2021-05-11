import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krenak/Scenes/Onboarding/Interest.dart';
import 'package:krenak/Scenes/Onboarding/Onboarding.dart';

import 'package:krenak/Services/Request/InterestRequest.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
import 'package:krenak/Services/Request/PreferencesRequest.dart';

class OnboardingView extends StatefulWidget {
  @override
  OnboardingViewState createState() {
    return OnboardingViewState();
  }
}

class OnboardingViewState extends State<OnboardingView> {
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    onboarding.interests = [];

    var interests = InterestRequest().execute();
    interests.then(handleRequest).catchError((e) {
      _showMaterialDialog(e.toString());
    });
  }

  handleRequest(value) {
    setState(() {
      interests = value.results;
    });
  }

  _showMaterialDialog(String mensagem) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Can't proceed."),
              content: new Text(mensagem),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  List<Interest> interests = [];
  Onboarding onboarding = Onboarding();
  String enrollmentType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Interesses'),
        ),
        body: Container(
            margin: const EdgeInsets.all(24.0),
            child: Form(
                key: _formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("O que você procura?"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (enrollmentType == 'MTR')
                                  return Colors.green;
                                return null; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {
                            onboarding.enrollmentType = 'MTR';
                            setState(() {
                              enrollmentType = 'MTR';
                            });
                          },
                          child: Text('Auxiliar Alunos'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (enrollmentType == 'MTE')
                                  return Colors.green;
                                return null; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {
                            onboarding.enrollmentType = 'MTE';
                            setState(() {
                              enrollmentType = 'MTE';
                            });
                          },
                          child: Text('Receber Mentoria'),
                        ),
                      ),
                      Text("Selecione suas áreas de interesse"),
                      Container(
                          child: GridView.count(
                              crossAxisCount: 3,
                              primary: true,
                              physics: new NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: interests
                                  .map((e) => Container(
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 36.0),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (onboarding.interests
                                                      .contains(e.id))
                                                    return Colors.green;
                                                  return null; // Use the component's default.
                                                },
                                              ),
                                            ),
                                            onPressed: () {
                                              if (onboarding.interests
                                                  .contains(e.id)) {
                                                onboarding.interests
                                                    .remove(e.id);
                                              } else {
                                                onboarding.interests.add(e.id);
                                              }
                                            },
                                            child: Text(e.description)),
                                      )))
                                  .toList())),
                      Text(
                          "Por que você gostaria de receber/dar essa mentoria?"),
                      TextFormField(
                        maxLines: 5,
                        onSaved: (String value) {
                          onboarding.resume = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            _formkey.currentState.save();
                            try {
                              await PreferencesRequest().execute(onboarding);
                              await FlutterSecureStorage().write(key: 'onboarding', value: 'done');
                              await MeRequest.shared.execute();
                              Navigator.pushReplacementNamed(context, '/home');
                            } catch (e) {
                              _showMaterialDialog(e.toString());
                            }
                          },
                          child: Text('Enviar'),
                        ),
                      )
                    ]))));
  }
}
