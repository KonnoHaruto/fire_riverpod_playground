import 'package:fire_riverpod_playground/model/item_model.dart';
import 'package:fire_riverpod_playground/repositories/item_repositories/base_item_repository.dart';

class ItemRepository implements BaseItemRepository {
  @override
  Future<String> createItem({required String userId, required Item item}) {
    // TODO: implement createItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem({required String userId, required String itemId}) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<List<Item>> retriveItems({required String userId}) {
    // TODO: implement retriveItems
    throw UnimplementedError();
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

}