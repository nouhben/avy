import 'dart:io';

import 'package:avy/models/avatar_reference.dart';
import 'package:avy/models/firestore_path.dart';
import 'package:avy/models/my_user.dart';
import 'package:avy/screens/about/about_screen.dart';
import 'package:avy/services/firebase_auth_service.dart';
import 'package:avy/services/firebase_storage_service.dart';
import 'package:avy/services/firestore_service.dart';
import 'package:avy/services/image_picker_service.dart';
import 'package:avy/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final picker = Provider.of<ImagePickerService>(context, listen: false);
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // 2. Upload to storage
        final storage = Provider.of<FirebaseStorageService>(
          context,
          listen: false,
        );
        // final auth = Provider.of<FirebaseAuthService>(context, listen: false);
        final user = Provider.of<MyUser>(
          context,
          listen: false,
        ); //auth.currentUser;
        final downloadUrl = await storage.uploadAvatar(
          uid: user.uid,
          file: image,
        );
        final firestore = Provider.of<FirestoreService>(
          context,
          listen: false,
        );
        await firestore.setAvatarReference(
          uid: user.uid,
          reference: AvatarReference(downloadURL: downloadUrl),
        );
      }

      // 4. (optional) delete local file as no longer needed
      await image!.delete();
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
          preferredSize: const Size.fromHeight(130.0),
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
    final fireStore = Provider.of<FirestoreService>(context, listen: false);
    final user = Provider.of<MyUser>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: fireStore.avatarReferenceStream(uid: user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final AvatarReference ref = (snapshot.data as AvatarReference);

          return Avatar(
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPress: () => _chooseAvatar(context),
            photoURL: ref.downloadURL,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
