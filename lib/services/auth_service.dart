abstract class AuthService<T> {
  Future<T> currentUser();
  Future<T> signInAnon();
  Future<T> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<T> createUserWithEmailAndPassword(
      {required String email, required String password});
  Future<void> sendRestPasswordEmail({required String email});
  Future<T> signInWithGoogle();
  Future<T> signInWithApple();
  Future<T> signInWithFacebook();
  Future<void> signOut();
  void dispose();
  Stream<T> get onAuthStateChanged;
}
