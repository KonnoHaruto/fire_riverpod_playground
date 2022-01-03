import 'package:fire_riverpod_playground/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));