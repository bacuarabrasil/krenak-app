import 'package:flutter/material.dart';

import 'package:krenak/Scenes/Register/Register.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

class RegisterView extends StatefulWidget {
  @override
  RegisterViewState createState() {
    return RegisterViewState();
  }
}

class RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  Register register = Register();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
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
                    decoration: InputDecoration(hintText: 'Nome'),
                    onSaved: (String value) {
                      register.firstName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Sobrenome'),
                    onSaved: (String value) {
                      register.lastName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String value) {
                      register.email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Data de nascimento'),
                    keyboardType: TextInputType.datetime,
                    onSaved: (String value) {
                      register.birthdate = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    onSaved: (String value) {
                      register.password = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        try {
                          await AuthStore().createUser(register);
                          Navigator.pushReplacementNamed(
                              context, '/onboarding');
                        } catch (e) {
                          // Do nothing
                        }
                      },
                      child: Text('Registrar'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Entrar'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
