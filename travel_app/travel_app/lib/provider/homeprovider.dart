import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/allConstants/allconstants.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore;

  HomeProvider({required this.firebaseFirestore});

  Future<void> updateFirestoreData(String collectionPath, String path, Map<String,dynamic> updateData) {
    return firebaseFirestore.collection(collectionPath)
      .doc(path)
      .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(String collectionPath, int limit, String? _textSearch) {
    if(_textSearch != null && _textSearch.isNotEmpty) {
      return firebaseFirestore.collection(collectionPath)
        .limit(limit)
        .where(FirestoreConstants.displayName, isEqualTo: _textSearch)
        .snapshots();
    } else {
      return firebaseFirestore.collection(collectionPath)
        .limit(limit)
        .snapshots();
    }
  }
}