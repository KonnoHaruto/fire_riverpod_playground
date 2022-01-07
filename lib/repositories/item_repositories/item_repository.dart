import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../exception/custom_exception.dart';
import '../../extensions/firebase_firestore_extension.dart';
import '../../firebase_instance_provider.dart';
import '../../model/item_model.dart';
import 'base_item_repository.dart';

class ItemRepository implements BaseItemRepository {
  final Reader _read;

  const ItemRepository(this._read);

  @override
  // idをcontrollerに渡す
  Future<String> createItem({
    required String userId,
    required Item item,
  }) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .add(item.toDocument());
      return docRef.id;
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  @override
  Future<void> deleteItem({
    required String userId,
    required String itemId,
  }) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .doc(itemId)
          .delete();
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }

  // itemのsnapshotをcontrollerに渡す。
  @override
  Future<List<Item>> retriveItems({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).userListRef(userId).get();
      return snap.docs.map((doc) => Item.fromDocument(doc)).toList();
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }


  @override
  Future<void> updateItem({
    required String userId,
    required Item item,
  }) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (error) {
      throw CustomException(message: error.message);
    }
  }
}
