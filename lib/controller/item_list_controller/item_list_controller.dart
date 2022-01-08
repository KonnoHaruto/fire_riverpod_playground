import '../../exception/item_list_exception_provider.dart';
import '../../model/item_model.dart';
import '../../exception/custom_exception.dart';
import '../../repositories/item_repositories/item_repositoriy_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// firestoreが非同期なためAsyncValueでラップ
class ItemListController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _read;
  final String? _userId;

  ItemListController(this._read, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retriveItems();
    }
  }

  Future<void> retriveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items =
          await _read(itemRepositoryProvider).retriveItems(userId: _userId!);
      // mountedはdisposeメソッドが呼び出されたかを判定するもの
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (error, st) {
      state = AsyncValue.error(error, stackTrace: st);
    }
  }

  Future<void> addItem({
    required String name,
    bool obtained = false,
  }) async {
    try {
      final item = Item(name: name, obtained: obtained);
      final itemId = await _read(itemRepositoryProvider).createItem(
        userId: _userId!,
        item: item,
      );
      state.whenData((items) =>
          state = AsyncValue.data(items..add(item.copyWith(id: itemId))));
    } on CustomException catch (error) {
      _read(itemListExceptionProvider.notifier).state = error;
    }
  }

  Future<void> updateItem({required Item updatedItem}) async {
    try {
      await _read(itemRepositoryProvider).updateItem(
        userId: _userId!,
        item: updatedItem,
      );
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == updatedItem.id) updatedItem else item
        ]);
      });
    } on CustomException catch (error) {
      _read(itemListExceptionProvider.notifier).state = error;
    }
  }

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _read(itemRepositoryProvider).deleteItem(
        userId: _userId!,
        itemId: itemId,
      );
      state.whenData((items) => state =
          AsyncValue.data(items..removeWhere((item) => item.id == itemId)));
    } on CustomException catch (error) {
      _read(itemListExceptionProvider.notifier).state = error;
    }
  }
}