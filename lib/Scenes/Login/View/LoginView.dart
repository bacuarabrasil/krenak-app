import 'package:flutter/material.dart';
import 'package:krenak/Scenes/Register/View/RegisterView.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
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
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Senha'
                ),
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text('Entrar'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: Text('Registrar'),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}