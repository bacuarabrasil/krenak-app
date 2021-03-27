import 'package:flutter/material.dart';

import 'Scenes/Login/View/LoginView.dart';
import 'Scenes/Register/View/RegisterView.dart';
import 'Scenes/Home/View/HomeView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
      routes: {
        '/login': (context) => new LoginView(),
        '/register': (context) => new RegisterView(),
        '/home': (context) => new HomeView(),
      },
    );
  }
}
