import 'item_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository(ref.read));