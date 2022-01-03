import 'package:fire_riverpod_playground/general_providers.dart';
import 'package:fire_riverpod_playground/repositories/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_exception.dart';

class AuthRepository implements BaseAuthRepository {
  final Reader _read;
  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() {
    try {
    return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  @override
  Future<void> signInAnoymously() async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
    await _read(firebaseAuthProvider).signOut();
    await signInAnoymously();
    } on FirebaseAuthException catch (error) {
      throw CustomException(message: error.message);
    }
  }
}
