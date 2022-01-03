import 'dart:async';

import 'package:fire_riverpod_playground/repositories/auth_repository_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubsctiption;

  AuthController(this._read) : super(null) {
    _authStateChangesSubsctiption?.cancel();
    _authStateChangesSubsctiption = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }
}
