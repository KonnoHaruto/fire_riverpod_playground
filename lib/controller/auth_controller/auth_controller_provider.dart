import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_controller.dart';


// <Notifierクラスの型, 格納する状態の型>
final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)..appStarted(),
);