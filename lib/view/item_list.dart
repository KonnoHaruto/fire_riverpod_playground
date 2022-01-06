import 'package:fire_riverpod_playground/controller/item_list_controller/item_list_controller_provider.dart';
import 'package:fire_riverpod_playground/exception/custom_exception.dart';
import 'package:fire_riverpod_playground/model/item_model.dart';
import 'package:fire_riverpod_playground/view/add_item_dialog.dart';
import 'package:fire_riverpod_playground/view/item_list_error.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemList extends HookConsumerWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListControllerProvider);
    return itemListState.when(
      data: (items) => items.isEmpty
          ? const Center(
              child: Text(
                'Tap + to add an item',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              // 第二引数はlistのindexに使用
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return ProviderScope(
                  overrides: [currentItem.overrideWithValue(item)],
                  child: ListTile(
                    key: ValueKey(item.id),
                    title: Text(item.name),
                    trailing: Checkbox(
                      value: item.obtained,
                      onChanged: (value) => ref
                          .read(itemListControllerProvider.notifier)
                          .updateItem(
                              updatedItem:
                                  item.copyWith(obtained: !item.obtained)),
                    ),
                    onTap: () => AddItemDialog.show(context, item),
                    onLongPress: () => ref
                        .read(itemListControllerProvider.notifier)
                        .deleteItem(itemId: item.id!),
                  ),
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

final currentItem = Provider<Item>((_) => throw UnimplementedError());