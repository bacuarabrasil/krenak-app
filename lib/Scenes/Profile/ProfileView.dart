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

  @override
  void initState() {
    super.initState();
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
    _birthdateController.text = profile.birthdate[8]
    + profile.birthdate[9]
    + '/'
    + profile.birthdate[5]
    + profile.birthdate[6]
    + '/'
    + profile.birthdate[0]
    + profile.birthdate[1]
    + profile.birthdate[2]
    + profile.birthdate[3];
    setState(() {
      profile = profile;
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
        profile.birthdate = picked.year.toString() + '-' + monthString + '-' + dayString;
        selectedDate = picked;
        
        _birthdateController.text = dayString + '/' + monthString + '/' + picked.year.toString();
      });
  }

  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
        ),
        body: Container(
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
                    decoration: InputDecoration(hintText: 'Data de nascimento'),
                    keyboardType: TextInputType.datetime,
                    onSaved: (String value) {
                      profile.birthdate = value[6]
                        + value[7]
                        + value[8]
                        + value[9]
                        + '-'
                        + value[3]
                        + value[4]
                        + '-'
                        + value[0]
                        + value[1];
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
                        var updated = await MeRequest.shared.update(profile);
                        handleRequest(updated);
                      },
                      child: Text('Atualizar'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
