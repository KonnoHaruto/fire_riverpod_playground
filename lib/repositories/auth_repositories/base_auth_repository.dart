import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnoymously();
  User? getCurrentUser();
  Future<void> signOut();
}
