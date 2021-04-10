import 'package:flutter/material.dart';

import 'package:krenak/Scenes/Login/Login.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  Login login = Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
            margin: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    onSaved: (String value) {
                      login.email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Senha'),
                    onSaved: (String value) {
                      login.password = value;
                    },
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        try {
                          await AuthStore().loginUser(login);
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          // Do nothing
                        }
                      },
                      child: Text('Entrar'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Registrar'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
