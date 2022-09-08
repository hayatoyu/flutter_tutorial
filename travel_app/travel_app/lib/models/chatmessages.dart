import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/allConstants/allconstants.dart';

class ChatMessage {
  String idFrom;
  String idTo;
  String timeStamp;
  String content;
  int type;

  ChatMessage(this.idFrom,this.idTo,this.timeStamp,this.content,this.type);

  Map<String,dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timeStamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type
    };
  }

  factory ChatMessage.fromDocument(DocumentSnapshot documentSnapshot) {
    return ChatMessage(
      documentSnapshot.get(FirestoreConstants.idFrom),
      documentSnapshot.get(FirestoreConstants.idTo), 
      documentSnapshot.get(FirestoreConstants.timestamp), 
      documentSnapshot.get(FirestoreConstants.content), 
      documentSnapshot.get(FirestoreConstants.type)
    );
  }
}