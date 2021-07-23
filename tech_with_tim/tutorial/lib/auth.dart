import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

Future<FirebaseUser> signInWithUser() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await (googleSignInAccount!).authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
    );
  final UserCredential userCredential = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  assert(!(user!).isAnonymous);
  assert(await user!.getIdToken() != null);
}