import 'package:fire_riverpod_playground/controller/auth_controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


// <Notifierクラスの型, 格納する状態の型>
final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)..appStarted(),
);