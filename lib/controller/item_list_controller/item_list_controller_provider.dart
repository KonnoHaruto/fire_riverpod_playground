import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/item_model.dart';
import '../auth_controller/auth_controller_provider.dart';
import 'item_list_controller.dart';

final itemListControllerProvider = StateNotifierProvider<ItemListController, AsyncValue<List<Item>>>(
  (ref) {
  final user = ref.watch(authControllerProvider);
  return ItemListController(ref.read, user!.uid);
});
