import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ProfileProvider(
    {
      required this.prefs,
      required this.firebaseFirestore,
      required this.firebaseStorage
    }
  );

  String? getPrefs(String key) {
    return prefs.getString(key);
  }

  Future<bool> setPrefs(String key, String value) async {
    return await prefs.setString(key, value);
  }

  UploadTask uploadImageFile(File image, String fileName) {
    Reference ref = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(String collectionPath, String path, Map<String,dynamic> dataUpdate) {
    return firebaseFirestore.collection(collectionPath)
      .doc(path)
      .update(dataUpdate);
  }

}