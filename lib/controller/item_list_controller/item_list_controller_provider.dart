import 'package:fire_riverpod_playground/controller/auth_controller/auth_controller_provider.dart';
import 'package:fire_riverpod_playground/controller/item_list_controller/item_list_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemListControllerProvider = StateNotifierProvider((ref) {
  final user = ref.watch(authControllerProvider);
  return ItemListController(ref.read, user!.uid);
});
