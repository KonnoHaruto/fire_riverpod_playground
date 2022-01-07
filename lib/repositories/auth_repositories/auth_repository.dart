import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../exception/custom_exception.dart';
import '../../firebase_instance_provider.dart';
import 'base_auth_repository.dart';

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
