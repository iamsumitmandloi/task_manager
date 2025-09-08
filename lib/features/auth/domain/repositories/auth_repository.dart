import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

abstract class AuthRepository {
  Stream<fb_auth.User?> authStateChanges();
  fb_auth.User? get currentUser;
  Future<fb_auth.UserCredential> signIn(String email, String password);
  Future<fb_auth.UserCredential> signUp(String email, String password);
  Future<void> signOut();
}
