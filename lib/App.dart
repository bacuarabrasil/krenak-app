import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/ActivityDetailView.dart';
import 'package:krenak/Scenes/TaskEdit/TaskEditView.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

import 'Scenes/Login/LoginView.dart';
import 'Scenes/Register/RegisterView.dart';
import 'Scenes/Home/HomeView.dart';
import 'Scenes/Onboarding/OnboardingView.dart';
import 'Scenes/Profile/ProfileView.dart';
import 'Scenes/Activity/ActivityView.dart';
import 'Scenes/ActivityDetail/ActivityDetailView.dart';
import 'Scenes/ActivityCreate/ActivityCreateView.dart';
import 'Scenes/TaskCreate/TaskCreateView.dart';

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
                MeRequest.shared.execute();
                if (user.onboarding != 'done') {
                  return OnboardingView();
                }
                return HomeView();
              }
            }
            return LoginView();
          }),
      routes: {
        '/login': (context) => new LoginView(),
        '/register': (context) => new RegisterView(),
        '/home': (context) => new HomeView(),
        '/profile': (context) => new ProfileView(),
        '/onboarding': (context) => new OnboardingView(),
        // '/activity/detail': (context) => new ActivityDetailView(),
        // '/activity': (context) => new ActivityView(),
        // '/activity/create': (context) => new ActivityCreateView(),
        '/task/create': (context) => new TaskCreateView(),
        '/task/edit': (context) => new TaskEditView()
      },
    );
  }
}
