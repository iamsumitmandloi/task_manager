import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

/// State class for authentication containing the current user.
class AuthState {
  final fb_auth.User? user;
  const AuthState(this.user);
  bool get isAuthenticated => user != null;
}

/// Cubit for managing authentication state and listening to auth changes.
class AuthCubit extends Cubit<AuthState> {
  final fb_auth.FirebaseAuth _auth;
  AuthCubit(this._auth) : super(AuthState(_auth.currentUser)) {
    _auth.authStateChanges().listen((u) => emit(AuthState(u)));
  }

  fb_auth.User? get currentUser => state.user;
}
