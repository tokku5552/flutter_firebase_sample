import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_firebase_sample/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AuthRepository {
  Stream<firebase_auth.User?> get authStateChanges;
  Future<void> signInAnonymously();
  firebase_auth.User? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepositoryImpl(ref.read));

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._read);
  final Reader _read;

  @override
  Stream<firebase_auth.User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  firebase_auth.User? getCurrentUser() {
    return _read(firebaseAuthProvider).currentUser;
  }

  @override
  Future<void> signInAnonymously() async {
    await _read(firebaseAuthProvider).signInAnonymously();
  }

  @override
  Future<void> signOut() async {
    await _read(firebaseAuthProvider).signOut();
    await signInAnonymously();
  }
}
