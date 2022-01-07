import 'package:fire_riverpod_playground/controller/item_list_controller/item_list_controller_provider.dart';
import 'package:fire_riverpod_playground/view/add_item_dialog.dart';
import 'package:fire_riverpod_playground/view/item_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemTile extends HookConsumerWidget {
  const ItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItemProvider);
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.name),
      trailing: Checkbox(
        value: item.obtained,
        onChanged: (val) => ref
        .read(itemListControllerProvider.notifier)
        .updateItem(updatedItem: item.copyWith(obtained: !item.obtained)),
      ),
      // 処理はDialog側で行う。
      onTap: () => AddItemDialog.show(context, item),
      onLongPress: () => ref
      .read(itemListControllerProvider.notifier).deleteItem(itemId: item.id!),
    );
  }
}
