import 'package:flutter/material.dart';

import 'package:krenak/Scenes/Login/Login.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
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
  bool _loading = false;

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

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _loading
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
        appBar: AppBar(title: Text('Login')),
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
                          setState(() {
                            _loading = true;
                          });
                          try {
                            await AuthStore().loginUser(login);
                            await MeRequest.shared.execute();
                            setState(() {
                              _loading = false;
                            });
                            Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            _showMaterialDialog(e.toString());
                          }
                          setState(() {
                            _loading = false;
                          });
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
              )),
              new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ]));
  }
}
