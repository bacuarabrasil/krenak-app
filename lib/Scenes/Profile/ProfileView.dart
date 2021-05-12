import 'package:flutter/material.dart';

import 'package:krenak/Scenes/Profile/Profile.dart';
import 'package:krenak/Services/Request/MeRequest.dart';

class ProfileView extends StatefulWidget {
  @override
  ProfileViewState createState() {
    return ProfileViewState();
  }
}

class ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    var me = MeRequest.shared.meResponse;
    handleRequest(me);
  }

  handleRequest(value) {
    var profile = Profile(
        email: value.email,
        firstName: value.firstName,
        lastName: value.lastName,
        birthdate: value.birthdate);
    _emailController.text = profile.email;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _birthdateController.text = profile.birthdate[8] +
        profile.birthdate[9] +
        '/' +
        profile.birthdate[5] +
        profile.birthdate[6] +
        '/' +
        profile.birthdate[0] +
        profile.birthdate[1] +
        profile.birthdate[2] +
        profile.birthdate[3];
    setState(() {
      loading = false;
      profile = profile;
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

  DateTime selectedDate = DateTime(2003);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        var month = picked.month;
        var monthString = picked.month.toString();
        if (month < 10) {
          monthString = '0' + picked.month.toString();
        }
        var day = picked.day;
        var dayString = picked.day.toString();
        if (day < 10) {
          dayString = '0' + picked.day.toString();
        }
        profile.birthdate =
            picked.year.toString() + '-' + monthString + '-' + dayString;
        selectedDate = picked;

        _birthdateController.text =
            dayString + '/' + monthString + '/' + picked.year.toString();
      });
  }

  Profile profile = Profile();

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
        appBar: AppBar(
          title: Text('Perfil'),
        ),
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
                      controller: _firstNameController,
                      decoration: InputDecoration(hintText: 'Nome'),
                      onSaved: (String value) {
                        profile.firstName = value;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(hintText: 'Sobrenome'),
                      onSaved: (String value) {
                        profile.lastName = value;
                      },
                    ),
                    TextFormField(
                      enabled: false,
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String value) {
                        profile.email = value;
                      },
                    ),
                    TextFormField(
                      controller: _birthdateController,
                      decoration:
                          InputDecoration(hintText: 'Data de nascimento'),
                      keyboardType: TextInputType.datetime,
                      onSaved: (String value) {
                        if (value.length == 10) {
                          profile.birthdate = value[6] +
                              value[7] +
                              value[8] +
                              value[9] +
                              '-' +
                              value[3] +
                              value[4] +
                              '-' +
                              value[0] +
                              value[1];
                        }
                      },
                      onTap: () {
                        _selectDate(context);
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
                            var updated =
                                await MeRequest.shared.update(profile);
                            setState(() {
                              loading = false;
                            });
                            handleRequest(updated);
                          } catch (e) {
                            _showMaterialDialog(e.toString());
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Text('Atualizar'),
                      ),
                    ),
                  ],
                ),
              )),
          new Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
        ]));
  }
}
