import 'package:travel_app/profile/profile.dart';
import 'package:travel_app/activity/activity.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;


String userId = "hayato.yu";
String name = "Hayato";
String email = "hayato.yu@spectrumleaf.com";
String imageUrl = "";
Profile profile = Profile(userId, email, name);
GoogleSignInAccount? user;
List<Activity> list = [];

