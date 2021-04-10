import 'package:flutter/material.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

import 'Scenes/Login/LoginView.dart';
import 'Scenes/Register/RegisterView.dart';
import 'Scenes/Home/HomeView.dart';
import 'Scenes/Onboarding/OnboardingView.dart';
import 'Scenes/Profile/ProfileView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: AuthStore.shared.user,
          builder:
              (BuildContext context, AsyncSnapshot<LoginResponse> snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data;
              if (user.access != null && user.refresh != null) {
                return OnboardingView();
              }
            }
            return LoginView();
          }),
      routes: {
        '/login': (context) => new LoginView(),
        '/register': (context) => new RegisterView(),
        '/home': (context) => new OnboardingView(),
        '/profile': (context) => new ProfileView(),
        '/onboarding': (context) => new OnboardingView()
      },
    );
  }
}
