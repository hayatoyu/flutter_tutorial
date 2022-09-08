import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/allConstants/allconstants.dart';
import 'package:travel_app/models/chatmessages.dart';

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
    {
      required this.prefs,
      required this.firebaseFirestore,
      required this.firebaseStorage
    }
  );

  UploadTask uploadImageFile(File image, String filename) {
    Reference ref = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = ref.putFile(image);
    return uploadTask;
  }

  Future<void> updateFireStoreData(String collectionPath, String docPath, Map<String,dynamic> dataUpdate) {
    return firebaseFirestore.collection(collectionPath)
      .doc(docPath)
      .update(dataUpdate);
  }

  Stream<QuerySnapshot> getChatMessages(String groupChatId, int limit) {
    return firebaseFirestore.collection(FirestoreConstants.pathMessageCollection)
      .doc(groupChatId)
      .collection(groupChatId)
      .orderBy(FirestoreConstants.timestamp, descending: true)
      .limit(limit)
      .snapshots();
  }

  void SendChatMessages(String content, int type, String groupChatId, String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore.collection(FirestoreConstants.pathMessageCollection)
      .doc(groupChatId)
      .collection(groupChatId)
      .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessage chatMessages = ChatMessage(currentUserId, peerId, DateTime.now().millisecondsSinceEpoch.toString(), content, type);
    FirebaseFirestore.instance.runTransaction((transaction) async => transaction.set(documentReference, chatMessages.toJson()));
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}