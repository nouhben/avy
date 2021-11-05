import 'package:avy/screens/about/about_screen.dart';
import 'package:avy/widgets/avatar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      //TODO: implement
    } catch (e) {
      print(e);
    }
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      //TODO: implement
      // 1. Get image from picker
      // 2. Upload to storage
      // 3. Save url to Firestore
      // 4. (optional) delete local file as no longer needed
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const AboutScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () => _onAbout(context),
          icon: const Icon(Icons.help),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: [
              Avatar(
                radius: 50,
                borderColor: Colors.black54,
                borderWidth: 2.0,
                onPress: () => _chooseAvatar(context),
                photoURL: null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo({required BuildContext context}) {
    // TODO: Download and show avatar from Firebase storage
    return Avatar(
      radius: 50,
      borderColor: Colors.black54,
      borderWidth: 2.0,
      onPress: () => _chooseAvatar(context),
      photoURL: null,
    );
  }
}
