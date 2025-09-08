import '../repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class SignIn {
  final AuthRepository _repo;
  SignIn(this._repo);
  Future<fb_auth.UserCredential> call(String email, String password) =>
      _repo.signIn(email, password);
}
