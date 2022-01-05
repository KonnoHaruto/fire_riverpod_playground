import 'package:fire_riverpod_playground/model/item_model.dart';
import 'package:fire_riverpod_playground/repositories/custom_exception.dart';
import 'package:fire_riverpod_playground/repositories/item_repositories/item_repositoriy_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// AsyncValueでラップ
class ItemListController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _read;
  final String? _userId;

  ItemListController(this._read, this._userId)
      : super(const AsyncValue.loading());

  Future<void> retriveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items =
          await _read(itemRepositoryProvider).retriveItems(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }
}
