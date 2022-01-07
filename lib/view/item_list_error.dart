import '../controller/item_list_controller/item_list_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemListError extends HookConsumerWidget {
  final String message;
  const ItemListError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () =>  ref
              .read(itemListControllerProvider.notifier)
              .retriveItems(isRefreshing: true),
            child: const Text('再試行'),
            ),
        ],
      )
    );
  }
}
