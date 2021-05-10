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
    _birthdateController.text = profile.birthdate;
    setState(() {
      profile = profile;
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
                      profile.birthdate = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        var updated = await MeRequest().update(profile);
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
