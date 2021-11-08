import 'package:avy/models/avatar_reference.dart';
import 'package:avy/screens/home/home_screen.dart';
import 'package:avy/services/firestore_service.dart';
import 'package:avy/widgets/avatar.dart';
import 'package:avy/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: Column(
            children: const [
              //_buildUserInfo(context: context),
              AvatarWidget(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Advanced Provider Tutorials',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 32),
            Text(
              'by Andrea Bizzotto',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 32),
            Text(
              'codingwithflutter.com',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo({required BuildContext context}) {
    final database = Provider.of<FirestoreService>(context);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoURL: avatarReference?.downloadURL,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
        );
      },
    );
  }
}
