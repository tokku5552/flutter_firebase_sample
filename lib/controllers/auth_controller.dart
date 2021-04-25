import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_sample/repository/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider = StateNotifierProvider(
  (ref) => AuthController(ref.read)..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;
  StreamSubscription<User?>? _authStateChangeSubscription;

  AuthController(this._read) : super(null) {
    _authStateChangeSubscription?.cancel();
    _authStateChangeSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }
  @override
  void dispose() {
    _authStateChangeSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      await _read(authRepositoryProvider).signInAnonymously();
    }
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}
