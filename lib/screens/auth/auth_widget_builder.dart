import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:avy/models/my_user.dart';
import 'package:avy/screens/auth/signin_screen.dart';
import 'package:avy/screens/home/home_screen.dart';
import 'package:avy/services/firebase_auth_service.dart';
import 'package:avy/services/firebase_storage_service.dart';
import 'package:avy/services/firestore_service.dart';

/// This widget is needed to display whether the sign_in screen
/// or the home screen depending on the auth state
/// we use provider.of with listen=false because we only want to get the auth service
/// and not to register the widget as a listener
/// then we use a streamBuilder to automatically change the ui when the status of
/// auth changes

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<MyUser?>) builder;
  @override
  Widget build(BuildContext context) {
    final _authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    print('AuthWidgetBuilder build');
    return StreamBuilder<MyUser?>(
      stream: _authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final _user = snapshot.data;
        return _user == null
            ? builder(context, snapshot)
            : MultiProvider(
                providers: [
                  Provider<MyUser>.value(value: _user),
                  Provider<FirebaseStorageService>(
                    create: (_) => FirebaseStorageService(uid: _user.uid),
                  ),
                  Provider<FirestoreService>(
                    create: (_) => FirestoreService(uid: _user.uid),
                  ),
                ],
                child: builder(context, snapshot),
              );
        // This will make the user available to all descendant widgets of the home page
      },
    );
  }
}
