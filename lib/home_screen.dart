import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fire_riverpod_playground/controller/auth_controller.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
    );
  }
}
