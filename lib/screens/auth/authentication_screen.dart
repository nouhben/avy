import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  void _signInAnonymously() async {
    try {
      // TODO: Implement
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
          onPressed: _signInAnonymously,
          child: const Text('Sign in'),
        ),
      ),
    );
  }
}
