import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class AuthRemoteDataSource {
  final fb_auth.FirebaseAuth _auth;
  AuthRemoteDataSource(this._auth);

  Stream<fb_auth.User?> authStateChanges() => _auth.authStateChanges();

  fb_auth.User? get currentUser => _auth.currentUser;

  Future<fb_auth.UserCredential> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<fb_auth.UserCredential> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() => _auth.signOut();
}
