import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference userListRef(String userId) =>
      collection('userLists')
      .doc(userId)
      .collection('lists');
}
