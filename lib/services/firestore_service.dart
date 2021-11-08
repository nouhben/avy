import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:avy/models/avatar_reference.dart';
import 'package:avy/models/firestore_path.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  // Sets the avatar download url
  Future<void> setAvatarReference({required AvatarReference reference}) async {
    final path = FirestorePath.avatar(uid: uid);
    final ref = FirebaseFirestore.instance.doc(path);
    await ref.set(reference.toMap());
  }

  // Read the avatar's download url whenever it changes
  Stream<AvatarReference> avatarReferenceStream() {
    final path = FirestorePath.avatar(uid: uid);
    final ref = FirebaseFirestore.instance.doc(path);
    final snapshots = ref.snapshots();
    return snapshots.map(
      (snapshot) => AvatarReference.fromMap(snapshot.data()),
    );
  }
}
