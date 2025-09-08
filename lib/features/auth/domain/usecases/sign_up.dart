import '../repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class SignUp {
  final AuthRepository _repo;
  SignUp(this._repo);
  Future<fb_auth.UserCredential> call(String email, String password) =>
      _repo.signUp(email, password);
}
