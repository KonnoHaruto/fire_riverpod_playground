import 'package:fire_riverpod_playground/controller/item_list_controller/item_list_controller_provider.dart';
import 'package:fire_riverpod_playground/exception/custom_exception.dart';
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
              itemBuilder: (BuildContext context, int index) {
                // TODO: use item modifier.
                final item = items[index];
                return Container();
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
