import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  AuthRepositoryImpl(this._remote);

  @override
  Stream<fb_auth.User?> authStateChanges() => _remote.authStateChanges();

  @override
  fb_auth.User? get currentUser => _remote.currentUser;

  @override
  Future<fb_auth.UserCredential> signIn(String email, String password) =>
      _remote.signIn(email, password);

  @override
  Future<fb_auth.UserCredential> signUp(String email, String password) =>
      _remote.signUp(email, password);

  @override
  Future<void> signOut() => _remote.signOut();
}
