import '../controller/item_list_controller/item_list_controller_provider.dart';
import '../exception/custom_exception.dart';
import '../model/item_model.dart';
import 'item_list_error.dart';
import 'item_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// itemを保持
final currentItemProvider = Provider<Item>((_) => throw UnimplementedError());

class ItemList extends HookConsumerWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListControllerProvider);
    return itemListState.when(
      data: (items) => items.isEmpty
          ? const Center(
              child: Text(
                '＋ボタンを押してアイテムを追加',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                // itemをoverrideで保持
                return ProviderScope(
                  overrides: [currentItemProvider.overrideWithValue(item)],
                  child: const ItemTile(),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ItemListError(
        message:
            error is CustomException ? error.message! : 'Something went wrong!',
      ),
    );
  }
}
