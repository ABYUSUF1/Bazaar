import 'package:cloud_firestore/cloud_firestore.dart';

abstract final class FirestoreCollectionName {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static const String users = 'users';
  static const String wishlist = 'wishlist';
  static const String cart = 'cart';
}

class AuthFirestoreService {
  /// set Document
  Future<void> setDocument(String docId, Map<String, dynamic> data) async {
    await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(docId)
        .set(data);
  }

  // isDocumentExists
  Future<bool> isDocumentExists(String docId) async {
    final snapshot = await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(docId)
        .get();
    return snapshot.exists;
  }

  // get Document
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String docId) async {
    final snapshot = await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(docId)
        .get();
    return snapshot;
  }

  // update Document
  Future<void> updateDocument(String docId, Map<String, dynamic> data) async {
    await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(docId)
        .update(data);
  }
}

class WishlistFirestoreService {
  // Stream collection
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection(String userId) {
    return FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.wishlist)
        .snapshots();
  }

  // get collection
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String userId) async {
    final snapshot = await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.wishlist)
        .get();
    return snapshot;
  }

  // set Document
  Future<void> setDocument(
      String userId, String productId, Map<String, dynamic> data) async {
    await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.wishlist)
        .doc(productId) // Use the productId as the document ID
        .set(data);
  }

  // delete Document
  Future<void> deleteDocument(String userId, String productId) async {
    await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.wishlist)
        .doc(productId)
        .delete();
  }
}

class CartFirestoreService {
  // Stream collection
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection(String userId) {
    return FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.cart)
        .snapshots();
  }

  // get collection
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String userId) async {
    final snapshot = await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.cart)
        .get();
    return snapshot;
  }

  // set Document
  Future<void> setDocument(
      String userId, String productId, Map<String, dynamic> data) async {
    await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.cart)
        .doc(productId) // Use the productId as the document ID
        .set(data);
  }

  // delete Document
  Future<void> deleteDocument(String userId, String productId) async {
    await FirestoreCollectionName.firestore
        .collection(FirestoreCollectionName.users)
        .doc(userId)
        .collection(FirestoreCollectionName.cart)
        .doc(productId)
        .delete();
  }
}
