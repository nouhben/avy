import 'package:avy/models/avatar_reference.dart';
import 'package:avy/models/my_user.dart';
import 'package:avy/services/firebase_storage_service.dart';
import 'package:avy/services/firestore_service.dart';
import 'package:avy/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'avatar.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  late FirestoreService fireStore;
  bool _isLoading = false;

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
          file: image,
        );
        final firestore = Provider.of<FirestoreService>(
          context,
          listen: false,
        );
        await firestore.setAvatarReference(
          reference: AvatarReference(downloadURL: downloadUrl),
        );
      }

      // 4. (optional) delete local file as no longer needed
      //await image!.delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fireStore = Provider.of<FirestoreService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('AvatarWidget: Build');
    return StreamBuilder<AvatarReference>(
      stream: fireStore.avatarReferenceStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final AvatarReference ref = (snapshot.data as AvatarReference);

          return Avatar(
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPress: _isLoading
                ? null
                : () async {
                    print('loading a new avatar');
                    setState(() => _isLoading = true);
                    await _chooseAvatar(context).then(
                      (value) => setState(
                        () => _isLoading = true,
                      ),
                    );
                  },
            photoURL: ref.downloadURL,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
