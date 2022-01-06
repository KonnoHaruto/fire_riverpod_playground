import 'package:fire_riverpod_playground/view/add_item_dialog.dart';
import 'package:fire_riverpod_playground/controller/auth_controller/auth_controller_provider.dart';
import 'package:fire_riverpod_playground/model/item_model.dart';
import 'package:fire_riverpod_playground/view/item_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          // ignore: unnecessary_null_comparison
          leading: authControllerState != null
              ? IconButton(
                  onPressed: () => authControllerState.signOut(),
                  icon: const Icon(Icons.logout),
                )
              : null,
        ),
        body: const ItemList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AddItemDialog.show(context, Item.empty()),
          child: const Icon(Icons.add),
        ));
  }
}
