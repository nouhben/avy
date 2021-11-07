import 'package:avy/models/my_user.dart';
import 'package:avy/screens/auth/signin_screen.dart';
import 'package:avy/screens/home/home_screen.dart';
import 'package:avy/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This widget is needed to display whether the sign_in screen
/// or the home screen depending on the auth state
/// we use provider.of with listen=false because we only want to get the auth service
/// and not to register the widget as a listener
/// then we use a streamBuilder to automatically change the ui when the status of
/// auth changes

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<MyUser?>(
      stream: _authService.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final _user = snapshot.data;
          return _user == null
              ? const SignInScreen()
              : Provider<MyUser>.value(
                  value: _user,
                  child: const HomeScreen(),
                );
          // This will make the user available to all descendant widgets of the home page
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
