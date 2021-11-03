import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  Future<void> uploadAvatar(
      {required String uid, required XFile image}) async {}

  /// Generic file upload for any [path] and [contentType]
  Future<String> upload({
    required String path,
    required String uid,
    required String contentType,
    required File file,
  }) async {
    print('uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final UploadTask uploadTask = storageReference.putFile(
      file,
      SettableMetadata(
        contentType: contentType,
      ),
    );
    final snapshot = await uploadTask.whenComplete(
      () => print('upload completed ...'),
    );
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }
}
