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
  final _birthdateController = TextEditingController();

  Register register = Register();

  DateTime selectedDate = DateTime(2003);

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
        register.birthdate =
            picked.year.toString() + '-' + monthString + '-' + dayString;
        selectedDate = picked;

        _birthdateController.text =
            dayString + '/' + monthString + '/' + picked.year.toString();
      });
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
        appBar: AppBar(
          title: Text('Registro'),
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
                      controller: _birthdateController,
                      decoration:
                          InputDecoration(hintText: 'Data de nascimento'),
                      keyboardType: TextInputType.datetime,
                      onSaved: (String value) {
                        if (value.length == 10) {
                          register.birthdate = value[6] +
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
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      onSaved: (String value) {
                        register.password = value;
                      },
                    ),
                    SizedBox(height: 16),
                    Text("A senha deve conter mais de 8 caracteres."),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState.save();
                          setState(() {
                            _loading = true;
                          });
                          try {
                            await AuthStore().createUser(register);
                            setState(() {
                              _loading = false;
                            });
                            Navigator.pushReplacementNamed(
                                context, '/onboarding');
                          } catch (e) {
                            _showMaterialDialog(e.toString());
                          }
                          setState(() {
                            _loading = false;
                          });
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
              )),
              new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ]));
  }
}
