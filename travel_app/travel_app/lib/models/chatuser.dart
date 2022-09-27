import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app/allConstants/allconstants.dart';
import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final String id, photoUrl, displayname, phoneNumber, aboutMe;

  const ChatUser({required this.id,required this.photoUrl,required this.displayname,required this.phoneNumber,required this.aboutMe});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? displayname,
    String? phoneNumber,
    String? aboutMe
  }) => ChatUser(
    id: id ?? this.id, 
    photoUrl: photoUrl ?? this.photoUrl, 
    displayname: displayname ?? this.displayname, 
    phoneNumber: phoneNumber ?? this.phoneNumber, 
    aboutMe: aboutMe ?? this.aboutMe);
  
  Map<String,dynamic> toJson() => {
    FirestoreConstants.displayName: displayname,
    FirestoreConstants.photoUrl: photoUrl,
    FirestoreConstants.phoneNumber: phoneNumber,
    FirestoreConstants.aboutMe: aboutMe
  };

  factory ChatUser.fromDocument(DocumentSnapshot documentSnapshot) {
    String photoUrl = "", nickname = "", phoneNumber = "", aboutMe = "";
    try {
      photoUrl = documentSnapshot.get(FirestoreConstants.photoUrl);
      nickname = documentSnapshot.get(FirestoreConstants.displayName);
      phoneNumber = documentSnapshot.get(FirestoreConstants.phoneNumber);
      aboutMe = documentSnapshot.get(FirestoreConstants.aboutMe);
    } catch (e) {
      if(kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
      id: documentSnapshot.id, 
      photoUrl: photoUrl, 
      displayname: nickname, 
      phoneNumber: phoneNumber, 
      aboutMe: aboutMe
    );
  }

  @override
  List<Object?> get props => [id,photoUrl,displayname,phoneNumber,aboutMe];
}
