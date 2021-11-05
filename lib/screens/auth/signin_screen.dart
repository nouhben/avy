import 'package:avy/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  void _signInAnonymously({required BuildContext context}) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      final user = await auth.signInAnon();
      print('user: ${user!.uid}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign in'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInAnonymously(context: context),
          child: const Text('Sign in'),
        ),
      ),
    );
  }
}
