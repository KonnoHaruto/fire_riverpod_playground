import 'dart:async';

import 'package:fire_riverpod_playground/repositories/auth_repositories/auth_repository_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// <Notifierクラスの型, 格納する状態の型>
final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubsctiption;

  AuthController(this._read) : super(null) {
    _authStateChangesSubsctiption?.cancel();
    _authStateChangesSubsctiption = _read(authRepositoryProvider)
        .authStateChanges
        .listen((User? user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubsctiption?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      await _read(authRepositoryProvider).signInAnoymously();
    }
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}
