import 'package:avy/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? firebaseUser) =>
      firebaseUser == null ? null : MyUser(uid: firebaseUser.uid);
  Stream<MyUser?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<MyUser?> signInAnon() async {
    final result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebaseUser(result.user);
  }
}
