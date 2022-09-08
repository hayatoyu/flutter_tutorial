import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app/allConstants/allconstants.dart';
import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final String id, photoUrl, displayname, phoneNum, aboutMe;

  const ChatUser({required this.id,required this.photoUrl,required this.displayname,required this.phoneNum,required this.aboutMe});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? displayname,
    String? phoneNum,
    String? aboutMe
  }) => ChatUser(
    id: id ?? this.id, 
    photoUrl: photoUrl ?? this.photoUrl, 
    displayname: displayname ?? this.displayname, 
    phoneNum: phoneNum ?? this.phoneNum, 
    aboutMe: aboutMe ?? this.aboutMe);
  
  Map<String,dynamic> toJson() => {
    FirestoreConstants.displayName: displayname,
    FirestoreConstants.photoUrl: photoUrl,
    FirestoreConstants.phoneNumber: phoneNum,
    FirestoreConstants.aboutMe: aboutMe
  };

  factory ChatUser.fromDocument(DocumentSnapshot documentSnapshot) {
    String photoUrl = "", nickname = "", phoneNum = "", aboutMe = "";
    try {
      photoUrl = documentSnapshot.get(FirestoreConstants.photoUrl);
      nickname = documentSnapshot.get(FirestoreConstants.displayName);
      phoneNum = documentSnapshot.get(FirestoreConstants.phoneNumber);
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
      phoneNum: phoneNum, 
      aboutMe: aboutMe
    );
  }

  @override
  List<Object?> get props => [id,photoUrl,displayname,phoneNum,aboutMe];
}
