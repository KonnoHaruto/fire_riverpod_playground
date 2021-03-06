import '../../model/item_model.dart';

abstract class BaseItemRepository {
  Future<List<Item>> retriveItems({required String userId});
  Future<String> createItem({required String userId, required Item item});
  Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItem({required String userId, required String itemId});
}