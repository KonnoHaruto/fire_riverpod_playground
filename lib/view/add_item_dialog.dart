import '../controller/item_list_controller/item_list_controller_provider.dart';
import '../model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddItemDialog extends HookConsumerWidget {
  static void show(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(item: item),
    );
  }

  final Item item;

  const AddItemDialog({Key? key, required this.item}) : super(key: key);

  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: item.name);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'アイテム名'),
            ),
            const SizedBox(height: 12.0),
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                isUpdating
                    ? ref.read(itemListControllerProvider.notifier).updateItem(
                          updatedItem: item.copyWith(
                            name: textController.text.trim(),
                            obtained: item.obtained,
                          ),
                        )
                    : ref
                        .read(itemListControllerProvider.notifier)
                        .addItem(name: textController.text.trim());
                Navigator.of(context).pop();
              },
              child: Text(isUpdating ? '編集' : '追加'),
              style: ElevatedButton.styleFrom(
                primary:
                    isUpdating ? Colors.orange : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
