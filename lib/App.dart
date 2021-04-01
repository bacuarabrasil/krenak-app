import 'package:flutter/material.dart';
import 'package:krenak/Scenes/Profile/View/ProfileView.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

import 'Scenes/Login/View/LoginView.dart';
import 'Scenes/Register/View/RegisterView.dart';
import 'Scenes/Home/View/HomeView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: AuthStore.shared.user,
        builder: (BuildContext context, AsyncSnapshot<LoginResponse> snapshot) {
          if (snapshot.hasData) {
            var user = snapshot.data;
            if (user.access != null && user.refresh != null) {
              return HomeView();
            }
          }
          return LoginView();
        }
      ),
      routes: {
        '/login': (context) => new LoginView(),
        '/register': (context) => new RegisterView(),
        '/home': (context) => new HomeView(),
        '/profile': (context) => new ProfileView(),
      },
    );
  }
}
