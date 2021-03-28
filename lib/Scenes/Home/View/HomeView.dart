import 'package:flutter/material.dart';
import 'package:krenak/Services/Store/AuthStore.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                await AuthStore.shared.logout();
                Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                // Do nothing
              }
            },
            child: Text('Logout'),
          ),
        ),
      )
    );
  }
}
